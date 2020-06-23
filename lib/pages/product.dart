import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

_showWarnDialog(BuildContext context){
   showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Are you sure?'),
                            content: Text('cant undone'),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('discard')),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context, true);
                                  },
                                  child: Text('continue'))
                            ]);
                      });
}

  final String title, imageurl;
  ProductPage(this.title, this.imageurl) {}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      // onWillPop: () {
      //   print("-----------back button pressed-----------------");
      //   Navigator.pop(context, false);
      //   return Future.value(false);
      // },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageurl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(title),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Delete'),
                onPressed: () => _showWarnDialog(context),
                 
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
