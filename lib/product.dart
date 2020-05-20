import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> product;
  Products(this.product){
    print('[Products Widget] constructor');
  }
  @override
  Widget build(BuildContext context) {
     print('[Products Widget] build()');
    return Column(
      children: product
          .map(
            (element) => Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/leaves.jpg'),
                  Text(element)
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
