// -----------------------------Modal----------------------------
// Center(child: RaisedButton(child: Text('save'),
//     onPressed: () {
//       showModalBottomSheet(context: context, builder: (BuildContext context){
//         return Center(child: Text('This is modal'),);
//       });
//     },),);

import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;
  ProductEditPage({this.addProduct, this.updateProduct, this.product, this.productIndex});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  String titleValue;
  String productDescription;
  double price;

  final Map<String, dynamic> _formData = {
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
       initialValue:widget.product == null ? '' : widget.product['title'].toString(),
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product description'),
      maxLines: 5,
       initialValue:widget.product == null ? '' : widget.product['description'].toString(),
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      initialValue:widget.product == null ? '' : widget.product['price'].toString(),
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  void _submitForm() {
    _formKey.currentState.validate();
    _formKey.currentState.save();
    if(widget.product == null){
        widget.addProduct(_formData);
    }else{
      widget.updateProduct(widget.productIndex, _formData);
    }

    //widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    final Widget pageContent = GestureDetector(
      onTap: () {
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
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(title: Text('Edit Product')),
            body: pageContent,
          );
  }
}
