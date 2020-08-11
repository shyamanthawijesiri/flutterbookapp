import 'package:first_app/scope-model/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';


import './models/product.dart';
import './pages/auth.dart';
import 'pages/product.dart';
import 'pages/products.dart';
import 'pages/products_admin.dart';

void main() {
//debugPaintSizeEnabled = true;
//MapView.setApiKey("<your_api_key>");
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
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.deepOrange,
              accentColor: Colors.deepPurple),
          // home:AuthPage(),
          routes: {
            '/': (BuildContext context) =>
                !_isAuthenticated ? AuthPage() : ProductsPage(_model),
            // ProductsPage(_product ),

            // '/products': (BuildContext context) => ProductsPage(_product),
            // '/products': (BuildContext context) => ProductsPage(_model),

            // ProductsPage(_product,_addProduct, _deleteProduct),
            // '/admin': (BuildContext context) => ProductsAdiminPage(_addProduct, _updateProduct, _deleteProduct,_product),
            '/admin': (BuildContext context) =>
                !_isAuthenticated ? AuthPage() : ProductsAdiminPage(_model),
          },

          onGenerateRoute: (RouteSettings settings) {
            if (!_isAuthenticated) {
              return MaterialPageRoute<bool>(
                  builder: (BuildContext context) => AuthPage());
            }
            final List<String> pathElements = settings.name.split('/');
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'product') {
              final String productId = pathElements[2];
              final Product product =
                  _model.allProducts.firstWhere((Product product) {
                return product.id == productId;
              });
              //  model.selectProduct(productId);
              return MaterialPageRoute<bool>(
                builder: (BuildContext context) =>
                    !_isAuthenticated ? AuthPage() : ProductPage(product),
              );
            }
            return null;
          },

          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductsPage(_model),
              //  ProductsPage(_product, _addProduct, _deleteProduct),
            );
          },
        ));
  }
}
