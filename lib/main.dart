import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Card(child: Column(children: <Widget>[
          Image.asset('assets/cover1.jpg'),
          Text('my books')
        ],),),
      ),
    );
  }
}
