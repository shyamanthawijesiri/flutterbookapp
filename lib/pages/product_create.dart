

import 'package:flutter/material.dart';

class ProductCreatePage extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: RaisedButton(child: Text('save'), 
    onPressed: () {
      showModalBottomSheet(context: context, builder: (BuildContext context){
        return Center(child: Text('This is modal'),);
      });
    },),);
  }
}