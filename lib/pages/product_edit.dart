// -----------------------------Modal----------------------------
// Center(child: RaisedButton(child: Text('save'),
//     onPressed: () {
//       showModalBottomSheet(context: context, builder: (BuildContext context){
//         return Center(child: Text('This is modal'),);
//       });
//     },),);

import 'package:first_app/models/product.dart';
import 'package:first_app/scope-model/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  // final Function addProduct;
  // final Function updateProduct;
  // final Product product;
  // final int productIndex;
  // ProductEditPage(
  //     {this.addProduct, this.updateProduct, this.product, this.productIndex});
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

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'title required';
        }
      },
      decoration: InputDecoration(labelText: 'Product title'),
      initialValue:
          product == null ? '' : product.title.toString(),
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product description'),
      maxLines: 5,
      initialValue:
          product == null ? '' : product.description.toString(),
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product price'),
      keyboardType: TextInputType.number,
      initialValue:
          product == null ? '' : product.price.toString(),
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  void _submitForm(Function addProduct, Function updateProduct,Function setSelectedProduct, [int selectiveProductIndex]) {
    _formKey.currentState.validate();
    _formKey.currentState.save();
    print(_formData);
    if (selectiveProductIndex == null) {
      addProduct(
          _formData['title'],
          _formData['description'],
          _formData['image'],
           _formData['price'],
          ).then((_)=>{
            Navigator.pushReplacementNamed(context, '/products').then((_)=>setSelectedProduct(null))        
          });
    } else {
      updateProduct(
        
          
               _formData['title'],
               _formData['description'],
              _formData['image'],
               _formData['price'],
              ).then((_)=>{
            Navigator.pushReplacementNamed(context, '/products').then((_)=>setSelectedProduct(null))        
          });
    }

    //widget.addProduct(_formData);
    
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      return model.isLoading ? Center(child: CircularProgressIndicator()) : RaisedButton(
        child: Text('Save'),
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        onPressed:() =>  _submitForm(model.addProduct, model.updateProduct,model.selectProduct, model.selectiveProductIndex));
    });

    
  }

  Widget _buildPageContent(BuildContext context, Product product){
        final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return  GestureDetector(
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
                _buildTitleTextField(product),
                _buildDescriptionTextField(product),
                _buildPriceTextField(product),
                SizedBox(
                  height: 10.0,
                ),
                _buildSubmitButton()
              ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      final Widget pageContent = _buildPageContent(context, model.selectiveProduct);
      return model.selectiveProductIndex == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(title: Text('Edit Product')),
            body: pageContent,
          );
    });
  }
}
