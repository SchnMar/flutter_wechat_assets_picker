import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Column(
        children: <Widget>[
          Text('Test Page'),
          FlatButton(
            child: Text('Back to root'),
            onPressed: () => Navigator.of(context).popUntil(
              (Route route) => route.isFirst,
            ),
          )
        ],
      ),
    );
  }
}
