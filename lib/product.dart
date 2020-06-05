import 'package:first_app/pages/product.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> product;
  final Function deleteProduct;
  Products(this.product, {this.deleteProduct}) {
    print('[Products Widget] constructor');
  }
  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product[index]['image']),
          Text(product[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Details"),
                onPressed: () => Navigator.pushNamed<bool>(
                        context, '/product/' + index.toString())
                    .then((bool value) {
                  if (value) {
                    deleteProduct(index);
                  }
                  print(value);
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buidProductList() {
    Widget productCard;
    if (product.length > 0) {
      productCard = ListView.builder(
        itemBuilder: _buildProductItem,
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
