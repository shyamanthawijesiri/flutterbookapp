
import 'package:flutter/material.dart';
import '../product_manager.dart';
import './products_admin.dart';

class ProductsPage extends StatelessWidget {

final List<Map<String,String>> product;
final Function addProduct;
final Function deleteProduct;

ProductsPage(this.product, this.addProduct, this.deleteProduct);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            title: Text('Manage Product'),
            onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      )),
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: ProductManager(product,addProduct,deleteProduct),
    );
  }
}
