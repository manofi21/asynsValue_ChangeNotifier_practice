import 'package:asyncValue_changeProvider_practice/model/Card.dart';
import 'package:asyncValue_changeProvider_practice/trello_key.dart';
import 'package:asyncValue_changeProvider_practice/view_model/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  final String id;

  const TodoList({Key key, this.id}) : super(key: key);
  @override
  _TodoListState createState() => _TodoListState();
}

Future<List<TrelloCard>> tCard(String id) async {
  return await http
      .get(trelloApiCard(id))
      .then((value) => trelloCardFromJson(value.body));
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // body: FutureBuilder<List<TrelloCard>>(
        //     future: tCard(widget.id),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return ListView(
        //             children: snapshot.data.map((e) => Text(e.name)).toList());
        //       }
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     })
        body: Consumer(
          builder: (context, watch, child) {
            final todosState = watch(todosNotifierProvider(widget.id).state);
            return todosState.when(
              data: (todos) {
                return RefreshIndicator(
                  onRefresh: () {
                    return context
                        .read(todosNotifierProvider(widget.id))
                        .refresh();
                  },
                  child: ListView(
                    children: [
                      ...todos
                          .map(
                            (todo) => ProviderScope(
                              overrides: [currentTodo.overrideWithValue(todo)],
                              child: TodoItem(),
                            ),
                          )
                          .toList()
                    ],
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (e, st) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Todos could not be loaded'),
                    RaisedButton(
                      onPressed: () {
                        context
                            .read(todosNotifierProvider(widget.id))
                            .retryLoadingTodo();
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        );
  }
}

class TodoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, select) {
      final todo = watch(currentTodo);
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red),
          onDismissed: (_) {
            // context.read(todosNotifierProvider).remove(todo.id);
          },
          child: Text(todo.name),
          // child: FocusScope(
          //   child: Focus(
          //       onFocusChange: (isFocused) {
          //         if (!isFocused) {
          //           _hasFocus.value = false;
          //           context.read(todosNotifierProvider).edit(
          //               id: todo.id, description: _textEditingController.text);
          //         } else {
          //           _textEditingController
          //             ..text = todo.description
          //             ..selection = TextSelection.fromPosition(TextPosition(
          //                 offset: _textEditingController.text.length));
          //         }
          //       },
          //       child: ListTile(
          //           onTap: () {
          //             _hasFocus.value = true;
          //             _textFocusNode.requestFocus();
          //           },
          //           title: _hasFocus.value
          //               ? TextField(
          //                   focusNode: _textFocusNode,
          //                   controller: _textEditingController,
          //                 )
          //               : Text(todo.description),
          //           trailing: Row(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Checkbox(
          //                 value: todo.completed,
          //                 onChanged: (_) {
          //                   context.read(todosNotifierProvider).toggle(todo.id);
          //                 },
          //               ),
          //               IconButton(
          //                   icon: Icon(Icons.delete),
          //                   onPressed: () {
          //                     context
          //                         .read(todosNotifierProvider)
          //                         .remove(todo.id);
          //                   })
          //             ],
          //           ))),
          // ),
        ),
      );
    });
  }
}
