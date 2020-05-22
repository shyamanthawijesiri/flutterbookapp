import 'package:flutter/material.dart';

import './product.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
 final String startingProduct;

  ProductManager({this.startingProduct = 'sweet tester'}){
    print('[ProductManager widget] Constructor');
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print('[ProductManager widget] createState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _product = [];

  @override
  void initState() {
    print('[ProductManager state] initState()');
    _product.add(widget.startingProduct);
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    // TODO: implement didUpdateWidget
    print('[ProductManager widget] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(String product){
     setState(() {
                _product.add(product);
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('[ProductManager state] build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProduct),
        ),
        Expanded(child: Products(_product))
      ],
    );
  }
}
