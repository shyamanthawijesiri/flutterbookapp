import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  final String title, imageurl;
  ProductPage(this.title, this.imageurl){}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(onWillPop: (){
      print("-----------back button pressed-----------------");
      Navigator.pop(context, false);
      return Future.value(false);
    },child: Scaffold(
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
            child: Text('Delete'),
            onPressed: () => Navigator.pop(context, true),
          ) ,
            ),
          
        ],
      ),
    ),);
  }
}
