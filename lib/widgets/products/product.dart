import 'package:first_app/models/product.dart';
import 'package:first_app/pages/product.dart';
import 'package:first_app/scope-model/main.dart';
import 'package:first_app/widgets/products/price_tag.dart';
import 'package:first_app/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  // final List<Product> product;
  // // final Function deleteProduct;
  // Products(this.product) {
  //   print('[Products Widget] constructor');
  // }
  // Products(this.product, {this.deleteProduct}) {
  //   print('[Products Widget] constructor');
  // }

  Widget _buidProductList(List<Product> product) {
    Widget productCard;
    if (product.length > 0) {
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(product[index], index),
        itemCount: product.length,
      );
    } else {
      //productCard = Container(); can use when productCard is empty
      productCard = Center(
        child: Text("no product is found"),
      );
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
    return _buidProductList(model.displayProducts);
    }); 
  }
}
