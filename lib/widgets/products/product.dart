import 'package:first_app/pages/product.dart';
import 'package:first_app/widgets/products/price_tag.dart';
import 'package:first_app/widgets/products/product_card.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> product;
  // final Function deleteProduct;
  Products(this.product) {
    print('[Products Widget] constructor');
  }
  // Products(this.product, {this.deleteProduct}) {
  //   print('[Products Widget] constructor');
  // }

  Widget _buidProductList() {
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
    return _buidProductList();
  }
}
