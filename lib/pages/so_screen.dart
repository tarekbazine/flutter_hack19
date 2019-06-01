import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

final mainUrl =
    "https://api.stackexchange.com/2.2/search/advanced?order=desc&sort=activity&accepted=True&tagged=flutter&site=stackoverflow";

class SO extends StatefulWidget {
  @override
  _SOState createState() => _SOState();
}

class _SOState extends State<SO> {
  bool _isLoading = false;
  List _questions;

  final title = 'Main List';

  _getQuestions() {
    fetchQuestions().then((response) {
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);

//        // If server returns an OK response, parse the JSON
//        return Post.fromJson(json.decode(response.body));

        setState(() {
          _isLoading = true;
          _questions = extractedData["items"];
//          Iterable list = json.decode(response.body);
//          users = list.map((model) => User.fromJson(model)).toList();
        });
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    });
  }

  Future<http.Response> fetchQuestions() {
    return http.get(mainUrl);
  }

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(String title) {
    return GestureDetector(
      onTap: () {
//          Navigator.pushNamed(context, routName);
        print("onTap called.");
      },
      child: ListTile(
//            leading: Text(
//              type,
//            ),
        title: Text(
          title,
          style: _biggerFont,
        ),
        trailing: Icon(Icons.dashboard),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getQuestions();

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _isLoading
            ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
              )
            : ListView.builder(
                itemCount: _questions.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (BuildContext context, int i) {
//                    if (i.isOdd) return Divider();
//            final index = i ~/ 2 + 1;
                  final element = _questions[i];
                  return _buildRow(element['title']);
                },
              ),
      ),
    );
  }
}
