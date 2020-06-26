import 'package:first_app/models/product.dart';
import 'package:first_app/pages/product.dart';
import 'package:first_app/pages/product_list.dart';
import 'package:flutter/material.dart';

import 'product_edit.dart';
import 'products.dart';

class ProductsAdiminPage extends StatelessWidget {
  // final Function addProduct;
  // final Function deleteProduct;
  // final Function updateProduct;
  // final List<Product> products;

  // ProductsAdiminPage(this.addProduct,this.updateProduct, this.deleteProduct, this.products);
  @override
Widget _buildSlideDrawer(BuildContext context){
  return Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('All product'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          ),
        );
}

  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSlideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Productt'),
          bottom: TabBar(tabs: <Widget>[
            Tab(icon: Icon(Icons.create), text: 'Create product'),
            Tab(icon: Icon(Icons.list), text: 'my product')
          ]),
        ),
        body: TabBarView(children: <Widget>[
          // ProductEditPage(addProduct:addProduct),
          // ProductListPage(products, updateProduct, deleteProduct),
          ProductEditPage(),
          ProductListPage(),
        ]),
      ),
    );
  }
}
