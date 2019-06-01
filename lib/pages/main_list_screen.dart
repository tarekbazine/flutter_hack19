import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainList extends StatelessWidget {
  var mainList = [
    ['Questions', 'StackOverflow', '/so_route', 'so.png'],
    [],
    ['Questions', 'Reddit', '/reddit_route', 'reddit.png'],
    [],
    ['Code         ', 'Github', '/github_route', 'github.png'],
    [],
    ['Guide         ', 'FAQ', '/main_list', 'faqs.png'],
    [],
    ['Guide         ', 'Tips', '/main_list', 'tips.png'],
    [],
    ['Guide         ', 'Tutorials', '/main_list', 'directions.png'],
    [],
  ];

  @override
  Widget build(BuildContext context) {
    final _biggerFont = const TextStyle(fontSize: 18.0);

    Widget _buildRow(String type, String name, String routName, String img) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routName);
        },
        child: ListTile(
          leading: Text(
            type,
            style: TextStyle(color: Colors.grey),
          ),
          title: Text(
            name,
            style: _biggerFont,
          ),
          trailing: Image.asset(
            'assets/imgs/' + img,
            fit: BoxFit.contain,
            height: 24,
            width: 24,
          ),
        ),
      );
    }

    final title = 'Sources';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: mainList.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return Divider();
          final element = mainList[i];
          return _buildRow(element[0], element[1], element[2], element[3]);
        },
      ),
    );
  }
}
