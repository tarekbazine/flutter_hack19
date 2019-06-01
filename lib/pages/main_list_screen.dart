import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var mainList = [
  ['Question', 'StackOverflow','/so_route'],
  [],
  ['Question', 'Reddit','/reddit_route'],
  [],
  ['Code', 'Github','/github_route'],
  [],
];

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _biggerFont = const TextStyle(fontSize: 18.0);

    Widget _buildRow(String type, String name, String routName) {
      return GestureDetector(
        onTap: () {
//          Navigator.pushNamed(context, routName);
          print("onTap called.");
        },
        child: ListTile(
          leading: Text(
            type,
          ),
          title: Text(
            name,
            style: _biggerFont,
          ),
          trailing: Icon(Icons.dashboard),
        ),
      );
    }

    final title = 'Main List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: mainList.length,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int i) {
            if (i.isOdd) return Divider();
//            final index = i ~/ 2 + 1;
            final element = mainList[i];
            return _buildRow(element[0], element[1], element[1]);
          },
        ),
      ),
    );
  }
}
