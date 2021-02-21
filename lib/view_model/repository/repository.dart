import 'package:asyncValue_changeProvider_practice/model/Card.dart';
import 'package:asyncValue_changeProvider_practice/model/List.dart';
import 'package:flutter/material.dart';

abstract class TodoRepository {
  Future<List<TrelloList>> retrieveList();
  Future<List<TrelloCard>> retrieveTodos(String id);
  Future<void> addTodo(String idList,String name, String description);
  Future<void> toggle(String id);
  Future<void> edit({
    @required String id,
    @required String name,
    @required String description,
  });
  Future<void> remove(String id);
}


// trelloApiCard
