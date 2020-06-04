import 'package:flutter/material.dart';

import './product_manager.dart';
import './pages/auth.dart';
import 'pages/products.dart';
import 'pages/products_admin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple
      ),
      //home:AuthPage(),
      routes: {
        '/' : (BuildContext context) => ProductsPage(),
        '/admin' : (BuildContext context) => ProductsAdiminPage(),
      },

    );
  }
}
