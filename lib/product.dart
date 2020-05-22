import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> product;
  Products([this.product = const []]){
    print('[Products Widget] constructor');
  }
  Widget _buildProductItem(BuildContext context, int index){
    return Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/leaves.jpg'),
                  Text(product[index])
                ],
              ),
            );
  }
  @override
  Widget build(BuildContext context) {
     print('[Products Widget] build()');
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: product.length,
      
    );
  }
}
