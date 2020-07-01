import 'package:first_app/scope-model/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

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
 

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child:MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
     // home:AuthPage(),
      routes: {
        '/': (BuildContext context) =>
           // ProductsPage(_product ),
            AuthPage(),
       // '/products': (BuildContext context) => ProductsPage(_product),
        '/products': (BuildContext context) => ProductsPage(),
            
            // ProductsPage(_product,_addProduct, _deleteProduct),
       // '/admin': (BuildContext context) => ProductsAdiminPage(_addProduct, _updateProduct, _deleteProduct,_product),
        '/admin': (BuildContext context) => ProductsAdiminPage(),
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
                ProductPage(index),
          );
        }
        return null;
      },

      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              ProductsPage(),
            //  ProductsPage(_product, _addProduct, _deleteProduct),
        );
      },
    ));
  }
}
