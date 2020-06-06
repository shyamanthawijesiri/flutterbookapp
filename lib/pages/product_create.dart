// -----------------------------Modal----------------------------
// Center(child: RaisedButton(child: Text('save'), 
//     onPressed: () {
//       showModalBottomSheet(context: context, builder: (BuildContext context){
//         return Center(child: Text('This is modal'),);
//       });
//     },),);

import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget{

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreatePageState();
  }
}
class _ProductCreatePageState extends State<ProductCreatePage>{
String titleValue = '';

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children:<Widget>[
      TextField(onChanged: (String value){
        setState(() {
          titleValue = value;
        });
      },),
      Text(titleValue),
    ]);
  }
}