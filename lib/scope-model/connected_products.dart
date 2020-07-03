import 'dart:convert';

import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;
  bool _isLoading = false;
  final url = 'https://flutter-product-80e90.firebaseio.com/';

  Future<Null> addProduct(
      String title, String description, String image, double price) {
        _isLoading = true;
        notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://perfectdailygrind.com/wp-content/uploads/2020/04/Hs_5Ce8ecmXodh-AdEVHyT07irPaZ-zAAhYkKYRJgS5CVzHKs0cAAdyeAF9TIgyh4KI5gqYmyuIDwJnf2f9wCdNvJ5WbQOlSoRr5zmmzMalyR1-RQxvlOtTZkJq9G_GPUiVZ6_WX-1-1.jpeg',
      'price': price,
      'userEmail':_authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    return http
        .post('https://flutter-product-80e90.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
          print(json.decode(response.body));
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
    });
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavourite = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayProducts {
    if (_showFavourite) {
      return _products.where((Product product) => product.isFavourite).toList();
    }
    return List.from(_products);
  }

  int get selectiveProductIndex {
    return _selProductIndex;
  }

  Product get selectiveProduct {
    if (selectiveProductIndex == null) {
      return null;
    }
    return _products[selectiveProductIndex];
  }

  bool get displayFavouriteOnly {
    return _showFavourite;
  }

  void deleteProduct() {
    _products.removeAt(selectiveProductIndex);
    notifyListeners();
  }

  Future<Null> updateProduct(
      String title, String description, String image, double price) {
        _isLoading = true;
        notifyListeners();
        final Map<String, dynamic> updateData = {
          'title': title,
          'description': description,
          'image':
              'https://perfectdailygrind.com/wp-content/uploads/2020/04/Hs_5Ce8ecmXodh-AdEVHyT07irPaZ-zAAhYkKYRJgS5CVzHKs0cAAdyeAF9TIgyh4KI5gqYmyuIDwJnf2f9wCdNvJ5WbQOlSoRr5zmmzMalyR1-RQxvlOtTZkJq9G_GPUiVZ6_WX-1-1.jpeg',
          'price': price,
          'userEmail':_authenticatedUser.email,
          'userId': _authenticatedUser.id
        };
         return http.put(url+'products/${selectiveProduct.id}.json', body: json.encode(updateData)).then((http.Response response){
          _isLoading =false;
                final Product updateProduct = Product(
                id: selectiveProduct.id,
                title: title,
                description: description,
                price: price,
                image: image,
                userEmail: selectiveProduct.userEmail,
                userId: selectiveProduct.userId);
                _products[selectiveProductIndex] = updateProduct;
                notifyListeners();
        });

  }

  void selectProduct(int index) {
    this._selProductIndex = index;
  }

  void fetchProduct() {
    _isLoading = true;
    notifyListeners();
    http
        .get('https://flutter-product-80e90.firebaseio.com/products.json')
        .then((http.Response response) {
          final List<Product> fetchedProductList = [];
          final Map<String, dynamic> productListData = json.decode(response.body);
          if(productListData == null){
            _isLoading = false;
            notifyListeners();
            return;
          }
          productListData.forEach((String productId,dynamic productData ){
            final Product product = Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              image: productData['image'],
              price: productData['price'],
              userEmail: productData['userEmail'],
              userId: productData['userId'],
            );
            fetchedProductList.add(product);
          });  
          _products = fetchedProductList;
          _isLoading = false;
          notifyListeners();
        });
  }

  void toggleProductFavouriteStatus() {
    final bool isCurrentFavourite = selectiveProduct.isFavourite;
    final bool newFavouriteStatus = !isCurrentFavourite;
    final Product updateProduct = Product(
        title: selectiveProduct.title,
        description: selectiveProduct.description,
        price: selectiveProduct.price,
        image: selectiveProduct.image,
        userEmail: selectiveProduct.userEmail,
        userId: selectiveProduct.userId,
        isFavourite: newFavouriteStatus);
    _products[selectiveProductIndex] = updateProduct;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavourite = !_showFavourite;
    notifyListeners();
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: '1', email: email, password: password);
  }
}
class UtilityModel extends ConnectedProductsModel{
  bool get isLoading{
    return _isLoading;
  }
}
