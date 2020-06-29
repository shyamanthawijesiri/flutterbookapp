import 'dart:html';

import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {

 List<Product> _products = [];
 int _selectiveProductIndex;
 List<Product> get Products{

   return List.from(_products);
 }

 int get selectiveProductIndex{
   return _selectiveProductIndex;
 }

 Product get selectiveProduct{
   if(_selectiveProductIndex == null){
     return null; 
   }
   return _products[_selectiveProductIndex];
 }

  void addProduct(Product product) {

      _products.add(product);
      _selectiveProductIndex = null;
      notifyListeners();

  }

  void deleteProduct() {
  
      _products.removeAt(_selectiveProductIndex);
      _selectiveProductIndex = null;
      notifyListeners();
  }
  void updateProduct( Product product){
  
      _products[_selectiveProductIndex] = product;
      _selectiveProductIndex = null;
      notifyListeners();
  }

  void selectProduct(int index){
      this._selectiveProductIndex = index;
      
  }

  void toggleProductFavouriteStatus(){
    final bool isCurrentFavourite  = selectiveProduct.isFavourite;
    final bool newFavouriteStatus = !isCurrentFavourite;
    final Product updateProduct = Product(
      title: selectiveProduct.title,
      description: selectiveProduct.description,
      price: selectiveProduct.price,
      image: selectiveProduct.image,
      isFavourite: newFavouriteStatus
    );
    _products[_selectiveProductIndex]=updateProduct;
    _selectiveProductIndex = null;
    notifyListeners();
  }

}