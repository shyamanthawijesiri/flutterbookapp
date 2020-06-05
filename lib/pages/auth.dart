import 'package:first_app/pages/product.dart';
import 'package:first_app/pages/products_admin.dart';
import 'package:flutter/material.dart';

import '../product_manager.dart';
import './products.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
          child: RaisedButton(
        child: Text('Login'),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
      )),
    );
  }
}
