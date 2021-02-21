import 'package:asyncValue_changeProvider_practice/model/Card.dart';
import 'package:asyncValue_changeProvider_practice/view_model/repository/repository.dart';
import 'package:asyncValue_changeProvider_practice/view_model/repository/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentTodo = ScopedProvider<TrelloCard>(null);

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  throw UnimplementedError();
  // return TodoRepository();
});

final todosNotifierProvider =
    StateNotifierProvider.family<TodoNotifier, String>((ref, id) {
  return TodoNotifier(ref.read, id);
});

// final completedTodos = Provider<AsyncValue<List<TrelloCard>>>((ref) {
//   // Method 4
//   final todos = ref.watch(todosNotifierProvider.state);
//   return todos
//       .whenData((todos) => todos.where((todo) => todo).toList());
// });

final todoExceptionProvider = StateProvider<TodoException>((ref) {
  return null;
});

class TodoNotifier extends StateNotifier<AsyncValue<List<TrelloCard>>> {
  TodoNotifier(
    this.read,
    this.id, [
    AsyncValue<List<TrelloCard>> todos,
  ]) : super(AsyncValue.data([]) ?? const AsyncValue.loading()) {
    _retrieveTodos();
  }

  final Reader read;
  final String id;
  AsyncValue<List<TrelloCard>> previousState;
//////Default Method//////////////////////////////
  void _resetState() {
    if (previousState != null) {
      state = previousState;
      previousState = null;
    }
  }

  void _handleException(TodoException e) {
    _resetState();
    read(todoExceptionProvider).state = e;
  }

  void _cacheState() {
    previousState = state;
  }
////////////////////////////////////////////////////

  Future<void> _retrieveTodos() async {
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos(id);
      state = AsyncValue.data(todos);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> retryLoadingTodo() async {
    state = const AsyncValue.loading();
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos(id);
      state = AsyncValue.data(todos);
    } on TodoException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    try {
      final todos = await read(todoRepositoryProvider).retrieveTodos(id);
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(String idList, String name, String description) async {
    _cacheState();
    // state = state.whenData((todos) => [...todos]..add(Todo(description)));

    try {
      await read(todoRepositoryProvider).addTodo(idList, name, description);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  Future<void> edit(
      {@required String id, @required String name, String description}) async {
    _cacheState();
    state = state.whenData((todos) {
      return [
        for (final todo in todos)
          if (todo.id == id)
            TrelloCard(id: id, name: name, desc: description)
          else
            todo
      ];
    });

    try {
      await read(todoRepositoryProvider)
          .edit(id: id, name: name, description: description);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  Future<void> remove(String id) async {
    _cacheState();
    state = state.whenData(
      (value) => value.where((element) => element.id != id).toList(),
    );
    try {
      await read(todoRepositoryProvider).remove(id);
    } on TodoException catch (e) {
      _handleException(e);
    }
  }

  // Future<void> toggle(String id) async {
  //   if (read(settingsProvider).state.deleteOnComplete) {
  //     await remove(id);
  //   }

  //   _cacheState();
  //   state = state.whenData(
  //     (value) => value.map((todo) {
  //       if (todo.id == id) {
  //         return Todo(
  //           todo.description,
  //           id: todo.id,
  //           completed: !todo.completed,
  //         );
  //       }
  //       return todo;
  //     }).toList(),
  //   );
  //   try {
  //     await read(todoRepositoryProvider).toggle(id);
  //   } on TodoException catch (e) {
  //     _handleException(e);
  //   }
  // }
}
