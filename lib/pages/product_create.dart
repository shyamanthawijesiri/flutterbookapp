// -----------------------------Modal----------------------------
// Center(child: RaisedButton(child: Text('save'),
//     onPressed: () {
//       showModalBottomSheet(context: context, builder: (BuildContext context){
//         return Center(child: Text('This is modal'),);
//       });
//     },),);

import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;
  ProductCreatePage(this.addProduct);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue;
  String productDescription;
  double price;

  final Map<String, dynamic> _formData ={
      'title': null,
      'description': null,
      'price': null,
      'image': 'assets/leaves.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'title required';
        }
      },
      decoration: InputDecoration(labelText: 'Product title'),
      onSaved: (String value) {
       
          _formData['title'] = value;
  
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product description'),
      maxLines: 5,
      onSaved: (String value) {
       
          _formData['description'] = value;
     
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
       
          _formData['price'] = double.parse(value);
      
      },
    );
  }

  void _submitForm() {
    _formKey.currentState.validate();
    _formKey.currentState.save();
    
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: targetWidth,
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
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
                    onPressed: _submitForm)
              ]),
        ),
      ),
    );
  }
}
