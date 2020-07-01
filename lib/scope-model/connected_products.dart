import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);
    _products.add(newProduct);
    notifyListeners();
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

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updateProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: selectiveProduct.userEmail,
        userId: selectiveProduct.userId);
    _products[selectiveProductIndex] = updateProduct;
    notifyListeners();
  }

  void selectProduct(int index) {
    this._selProductIndex = index;
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
