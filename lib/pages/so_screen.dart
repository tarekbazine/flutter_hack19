import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

final mainUrl =
    "https://api.stackexchange.com/2.2/search/advanced?order=desc&sort=activity&accepted=True&tagged=flutter&site=stackoverflow&q=";

class SO extends StatefulWidget {
  @override
  _SOState createState() => _SOState();
}

class _SOState extends State<SO> {
  bool _isLoading = true;
  List _questions;

  var _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getQuestions('');

    _textController.addListener(() {
      //here you have the changes of your textfield
      print("value: ${_textController.text}");

      if (_textController.text.isNotEmpty) {
        _getQuestions(_textController.text);
        //use setState to rebuild the widget
        setState(() {
          _isLoading = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Clean up the controller when the Widget is disposed
    _textController.dispose();
  }

  _getQuestions(String q) {
    fetchQuestions(q).then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);

        setState(() {
          _isLoading = false;
          _questions = extractedData["items"];
        });
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    });
  }

  Future<http.Response> fetchQuestions(String q) {
    return http.get(mainUrl + q);
  }

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(String title, String url) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => _WebView(url: url, title: title)));
//          Navigator.pushNamed(context, routName);
        print("onTap called. " + url);
      },
      child: ListTile(
//            leading: Text(
//              type,
//            ),
        title: Text(
          title,
          style: _biggerFont,
        ),
        trailing: Icon(
          Icons.check,
          color: Colors.green,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StackOverflow"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextField(
                  controller: _textController,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(),
                    ),
                    hintText: 'What are you looking for ?',
                    labelText: 'Search',
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          _isLoading
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                )
              : Expanded(
                  flex: 6,
                  child: Container(
                    child: ListView.builder(
                      itemCount: _questions.length,
                      padding: const EdgeInsets.only(
                          bottom: 16.0, left: 16.0, right: 16.0),
                      itemBuilder: (BuildContext context, int i) {
//                    if (i.isOdd) return Divider();
//            final index = i ~/ 2 + 1;
                        final element = _questions[i];
                        return _buildRow(element['title'], element['link']);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _WebView extends StatelessWidget {
  var url;
  var title;

  _WebView({Key key, this.url, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text(title),
      ),
    );
  }
}
