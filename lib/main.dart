import 'dart:convert';

import 'package:asyncValue_changeProvider_practice/view/todo_list.dart';
import 'package:asyncValue_changeProvider_practice/view_model/repository/todo_repository.dart';
import 'package:asyncValue_changeProvider_practice/view_model/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:asyncValue_changeProvider_practice/trello_key.dart';

import 'model/List.dart';
import 'view_model/repository/repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        overrides: [
          todoRepositoryProvider.overrideWithValue(TodoTrelloRepository())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

//retrieveList()

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() async {
    var response = await http.get(trelloApiList);
    // json.decode(response.body)
    final d = trelloListFromJson(response.body);
    final getRepos = await http.post(trelloPostCard() +
        "&idList=${d.first.id}&desc=description&name=See post APi");
    // print('Response body: ${trelloListFromJson(response.body).runtimeType}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: FutureBuilder<List<TrelloList>>(
      //     future: retrieveList(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return ListView(
      //           children: snapshot.data
      //               .map((e) => InkWell(
      //                   onTap: () {
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => TodoList(id: e.id)));
      //                   },
      //                   child: Text(e.name)))
      //               .toList(),
      //         );
      //       }
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }),
      body: Consumer(builder: (context, watch, child) {
        final state = watch(futureTrelloList);
        return state.when(
            data: (data) {
              return ListView.builder(
                  itemCount: data.length,
                  itemExtent: 15,
                  itemBuilder: (context, index) {
                    return Text(data[index].name);
                  });
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, _) {
              return Center(child: Text(e.toString()));
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
