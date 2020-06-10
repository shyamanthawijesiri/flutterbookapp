// -----------------------------Modal----------------------------
// Center(child: RaisedButton(child: Text('save'), 
//     onPressed: () {
//       showModalBottomSheet(context: context, builder: (BuildContext context){
//         return Center(child: Text('This is modal'),);
//       });
//     },),);

import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget{
final Function addProduct;
ProductCreatePage(this.addProduct);
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

Widget _buildTitleTextField(){
  return  TextField(
        decoration: InputDecoration(labelText: 'Product title'),
        onChanged: (String value){
        setState(() {
          titleValue = value;
        });
      },);
}
Widget _buildDescriptionTextField(){

  return TextField(
         decoration: InputDecoration(labelText: 'Product description'),
         maxLines: 5,
         onChanged: (String value){
        setState(() {
          productDescription = value;
        });
      },);
}
Widget _buildPriceTextField(){
   return TextField(
         decoration: InputDecoration(labelText: 'Product price'),
         keyboardType: TextInputType.number,
         onChanged: (String value){
        setState(() {
          price = double.parse(value);
        });
      },);
}

void _submitForm(){

  
        final Map<String, dynamic> product = {
            'title': titleValue,
            'description': productDescription,
            'price': price,
            'image': 'assets/leaves.jpg'
        };
        widget.addProduct(product);
        Navigator.pushReplacementNamed(context, '/');
      
  
}



@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ListView(children:<Widget>[
     _buildTitleTextField(),
       _buildDescriptionTextField(),
       _buildPriceTextField(),
      
      SizedBox(
        height: 10.0,
      ),
      RaisedButton(
        child: Text('Save'),
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        onPressed: _submitForm
         )
      
      
    ]),);
  }
}