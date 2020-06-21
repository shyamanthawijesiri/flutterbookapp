import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './models/product.dart';
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
  List<Product> _product = [];

  void _addProduct(Product product) {
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
  void _updateProduct(int index, Product product){
    setState(() {
      _product[index] = product;
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
           // ProductsPage(_product ),
            AuthPage(),
        '/products': (BuildContext context) => ProductsPage(_product),
            
            // ProductsPage(_product,_addProduct, _deleteProduct),
        '/admin': (BuildContext context) => ProductsAdiminPage(_addProduct, _updateProduct, _deleteProduct,_product),
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
                ProductPage(_product[index].title, _product[index].image),
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
