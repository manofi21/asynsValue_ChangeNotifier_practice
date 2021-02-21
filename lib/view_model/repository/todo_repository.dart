import 'package:asyncValue_changeProvider_practice/model/Card.dart';
import 'package:asyncValue_changeProvider_practice/model/List.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository.dart';
import 'package:http/http.dart' as http;
import 'package:asyncValue_changeProvider_practice/trello_key.dart';
// var url = 'https://example.com/whatsit/create';
// var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
// print('Response status: ${response.statusCode}');
// print('Response body: ${response.body}');

// print(await http.read('https://example.com/foobar.txt'));

class TodoException implements Exception {
  const TodoException(this.error);

  final String error;

  @override
  String toString() {
    return '''
Todo Error: $error
    ''';
  }
}

Future<List<TrelloList>> retrieveList() async {
  final getList = await http
      .get(trelloApiList)
      .then((value) => trelloListFromJson(value.body));
  return getList;
}

final futureTrelloList =
    FutureProvider<List<TrelloList>>((ref) async => await retrieveList());

class TodoTrelloRepository implements TodoRepository {
  TodoTrelloRepository() : mockTodoStorage = [];
  List<TrelloCard> mockTodoStorage;

  @override
  Future<void> addTodo(String idList, String name, String description) async {
    try {
      final postCard = trelloPostCard();
      final getRepos = await http
          .post(postCard + "&idList=$idList&desc=$description&name=$name");
      print(getRepos.statusCode);
    } catch (e) {
      throw TodoException(e.toString());
    }
  }

  @override
  Future<void> edit({String id, String name, String description}) async {
    try {
      final postCard = trelloPostCard(id: id);
      final getRepos =
          await http.put(postCard + "&desc=$description&name=$name");
      print(getRepos.statusCode);
    } catch (e) {
      throw TodoException(e.toString());
    }
  }

  @override
  Future<void> remove(String id) async {
    try {
      final postCard = trelloPostCard(id: id);
      final getRepos = await http.put(postCard);
      print(getRepos.statusCode);
    } catch (e) {
      throw TodoException(e.toString());
    }
  }

  @override
  Future<List<TrelloCard>> retrieveTodos(String id) async {
    try {
      final getRepos = await http
          .get(trelloApiCard(id))
          .then((value) => trelloCardFromJson(value.body));
      mockTodoStorage = [...getRepos];
      return mockTodoStorage;
    } catch (e) {
      throw TodoException(e.toString());
    }
  }

  @override
  Future<void> toggle(String id) {
    // TODO: implement toggle
    throw UnimplementedError();
  }

  @override
  Future<List<TrelloList>> retrieveList() async {
    // final getList = await http
    //     .get(trelloApiList)
    //     .then((value) => trelloListFromJson(value.body));
    // return getList;
  }
}
