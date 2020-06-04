import 'package:first_app/pages/product.dart';
import 'package:first_app/pages/product_list.dart';
import 'package:flutter/material.dart';

import 'product_create.dart';
import 'products.dart';

class ProductsAdiminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('All product'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProductsPage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Manage Productt'),
          bottom: TabBar(tabs: <Widget>[
            Tab(icon: Icon(Icons.create), text: 'Create product'),
            Tab(icon: Icon(Icons.list), text: 'my product')
          ]),
        ),
        body: TabBarView(children: <Widget>[
          ProductListPage(),
          ProductCreatePage()
        ]),
      ),
    );
  }
}
