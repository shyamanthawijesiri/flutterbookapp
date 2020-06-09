import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './product_manager.dart';
import './pages/auth.dart';
import 'pages/product.dart';
import 'pages/products.dart';
import 'pages/products_admin.dart';

void main(){
//debugPaintSizeEnabled = true;
runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _product = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _product.add(product);
    });
    print(_product);
  }

  void _deleteProduct(int index) {
    setState(() {
      _product.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
     // home:AuthPage(),
      routes: {
        '/': (BuildContext context) =>
            //ProductsPage(_product ),
            AuthPage(),
            
            // ProductsPage(_product,_addProduct, _deleteProduct),
        '/admin': (BuildContext context) => ProductsAdiminPage(_addProduct, _deleteProduct),
      },

      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) =>
                ProductPage(_product[index]['title'], _product[index]['image']),
          );
        }
        return null;
      },

      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              ProductsPage(_product),
            //  ProductsPage(_product, _addProduct, _deleteProduct),
        );
      },
    );
  }
}
