import 'package:first_app/pages/product.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> product;
  Products([this.product = const []]) {
    print('[Products Widget] constructor');
  }
  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/leaves.jpg'),
          Text(product[index]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Details"),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProductPage())),
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
