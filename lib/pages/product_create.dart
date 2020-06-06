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
String titleValue;
String productDescription;
double price;

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ListView(children:<Widget>[
      TextField(
        decoration: InputDecoration(labelText: 'Product title'),
        onChanged: (String value){
        setState(() {
          titleValue = value;
        });
      },),
       TextField(
         decoration: InputDecoration(labelText: 'Product description'),
         maxLines: 5,
         onChanged: (String value){
        setState(() {
          productDescription = value;
        });
      },),
       TextField(
         decoration: InputDecoration(labelText: 'Product price'),
         keyboardType: TextInputType.number,
         onChanged: (String value){
        setState(() {
          price = double.parse(value);
        });
      },),
      
      
    ]),);
  }
}