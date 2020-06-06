import 'package:flutter/material.dart';

import './product.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget {
//  final Map<String, String> startingProduct;
 
//   ProductManager({this.startingProduct }){
//     print('[ProductManager widget] Constructor');
//   }
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     print('[ProductManager widget] createState()');
//     return _ProductManagerState();
//   }
// }

// class _ProductManagerState extends State<ProductManager> {
//   List<Map<String, String>> _product = [];

//   @override
//   void initState() {
//     print('[ProductManager state] initState()');
//     if(widget.startingProduct != null){

//     _product.add(widget.startingProduct);
//     }
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(ProductManager oldWidget) {
//     // TODO: implement didUpdateWidget
//     print('[ProductManager widget] didUpdateWidget()');
//     super.didUpdateWidget(oldWidget);
//   }
final List<Map<String,dynamic>> product;
// final Function addProduct;
// final Function deleteProduct;

ProductManager(this.product);
//ProductManager(this.product, this.addProduct, this.deleteProduct);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('[ProductManager state] build()');
    return Column(
      children: [
        // Container(
        //   margin: EdgeInsets.all(10.0),
        //   child: ProductControl(addProduct),
        // ),
        Expanded(child: Products(product))
       // Expanded(child: Products(product, deleteProduct : deleteProduct))
      ],
    );
  }
}
