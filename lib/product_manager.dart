import 'package:flutter/material.dart';

import './product.dart';

class ProductManager extends StatefulWidget {
 final String startingProduct;

  ProductManager(this.startingProduct){
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('[ProductManager state] build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                _product.add('advance food');
              });
            },
            child: Text('add Product'),
          ),
        ),
        Products(_product)
      ],
    );
  }
}
