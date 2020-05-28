import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        children: <Widget>[
          Text('Deatils'),
          RaisedButton(
            child: Text('Back'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
