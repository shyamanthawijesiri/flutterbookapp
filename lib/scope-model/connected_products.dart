import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _selProductId;
  bool _isLoading = false;
  final url = 'https://flutter-product-80e90.firebaseio.com/';

  Future<Map<String, String>> uploadImage(File image,
      {String imagePath}) async {
    final mimeTypeData = lookupMimeType(image.path).split('/');
    final imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse(
            ' https://us-central1-flutter-product-80e90.cloudfunctions.net/storeImage'));
    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        imageUploadRequest.files.add(file);
      if(imagePath != null){
          imageUploadRequest.fields['imagePath'] = Uri.encodeComponent(imagePath);
      }
  }

  Future<bool> addProduct(
      String title, String description, File image, double price) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://perfectdailygrind.com/wp-content/uploads/2020/04/Hs_5Ce8ecmXodh-AdEVHyT07irPaZ-zAAhYkKYRJgS5CVzHKs0cAAdyeAF9TIgyh4KI5gqYmyuIDwJnf2f9wCdNvJ5WbQOlSoRr5zmmzMalyR1-RQxvlOtTZkJq9G_GPUiVZ6_WX-1-1.jpeg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    final http.Response response = await http.post(
        'https://flutter-product-80e90.firebaseio.com/products.json?auth=${_authenticatedUser.idToken}',
        body: json.encode(productData));
    try {
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

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
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
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

  String get selectiveProductId {
    return _selProductId;
  }

  Product get selectiveProduct {
    if (selectiveProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  bool get displayFavouriteOnly {
    return _showFavourite;
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    final deletedIndex = selectiveProduct.id;

    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    return http
        .delete(url +
            'products/${deletedIndex}.json?auth=${_authenticatedUser.idToken}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> updateProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'https://perfectdailygrind.com/wp-content/uploads/2020/04/Hs_5Ce8ecmXodh-AdEVHyT07irPaZ-zAAhYkKYRJgS5CVzHKs0cAAdyeAF9TIgyh4KI5gqYmyuIDwJnf2f9wCdNvJ5WbQOlSoRr5zmmzMalyR1-RQxvlOtTZkJq9G_GPUiVZ6_WX-1-1.jpeg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    return http
        .put(
            url +
                'products/${selectiveProduct.id}.json?auth=${_authenticatedUser.idToken}',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      final Product updateProduct = Product(
          id: selectiveProduct.id,
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: selectiveProduct.userEmail,
          userId: selectiveProduct.userId);
      _products[selectedProductIndex] = updateProduct;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void selectProduct(String productId) {
    _selProductId = productId;
  }

  Future<Null> fetchProduct({onlyForUser = false}) {
    _isLoading = true;
    notifyListeners();
    return http
        .get(
            'https://flutter-product-80e90.firebaseio.com/products.json?auth=${_authenticatedUser.idToken}')
        .then<Null>((http.Response response) {
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            isFavourite: productData['wishlistusers'] == null
                ? false
                : (productData['wishlistusers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
      _products = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
          : fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _selProductId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void toggleProductFavouriteStatus() async {
    final bool isCurrentFavourite = selectiveProduct.isFavourite;
    final bool newFavouriteStatus = !isCurrentFavourite;
    final Product updateProduct = Product(
        id: selectiveProduct.id,
        title: selectiveProduct.title,
        description: selectiveProduct.description,
        price: selectiveProduct.price,
        image: selectiveProduct.image,
        userEmail: selectiveProduct.userEmail,
        userId: selectiveProduct.userId,
        isFavourite: newFavouriteStatus);
    _products[selectedProductIndex] = updateProduct;
    notifyListeners();

    http.Response response;
    if (newFavouriteStatus) {
      response = await http.put(
          url +
              'products/${selectiveProduct.id}/wishlistusers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.idToken}',
          body: json.encode(true));
    } else {
      response = await http.delete(url +
          'products/${selectiveProduct.id}/wishlistusers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.idToken}');
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      final Product updateProduct = Product(
          id: selectiveProduct.id,
          title: selectiveProduct.title,
          description: selectiveProduct.description,
          price: selectiveProduct.price,
          image: selectiveProduct.image,
          userEmail: selectiveProduct.userEmail,
          userId: selectiveProduct.userId,
          isFavourite: !newFavouriteStatus);
      _products[selectedProductIndex] = updateProduct;
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavourite = !_showFavourite;
    notifyListeners();
  }
}

class UserModel extends ConnectedProductsModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  User get user {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDTKc_xYuFNMELfnBOfZgTzdfRCxeFGWHE',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
    } else {
      response = await http.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDTKc_xYuFNMELfnBOfZgTzdfRCxeFGWHE',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
    }

    bool hasError = true;
    String message = 'somethings went wrong';
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication successfully';
      _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          idToken: responseData['idToken']);
      setAuthTime(int.parse(responseData['expiresIn']));
      _userSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', responseData['idToken']);
      pref.setString('email', email);
      pref.setString('userId', responseData['localId']);
      pref.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Invalid password';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String token = pref.getString('token');
    final String expiryTime = pref.getString('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      final DateTime parsedExpiryTime = DateTime.parse(expiryTime);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String email = pref.getString('email');
      final String userId = pref.getString('userId');
      final int tokenLifeSpan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(id: userId, email: email, idToken: token);
      _userSubject.add(true);
      setAuthTime(tokenLifeSpan);
      notifyListeners();
    }
  }

  void logout() async {
    print('Logout');
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    pref.remove('email');
    pref.remove('userId');
  }

  void setAuthTime(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
