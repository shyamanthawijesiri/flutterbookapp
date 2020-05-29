import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  final String title, imageurl;
  ProductPage(this.title, this.imageurl){}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageurl),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(title),) ,
            Container(
              padding: EdgeInsets.all(10.0),
              child:RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text('Back'),
            onPressed: () => Navigator.pop(context),
          ) ,
            ),
          
        ],
      ),
    );
  }
}
