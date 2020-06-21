import 'package:first_app/models/product.dart';
import 'package:first_app/pages/product_edit.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;
  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

Widget _buildIconbtn(BuildContext context , int index){
  return IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return ProductEditPage(
                        product: products[index],
                        updateProduct: updateProduct,
                        productIndex: index,
                      );
                    }),
                  );
                });
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index].title),
          background: Container(color:Colors.red),
          onDismissed: (DismissDirection direction){
            if(direction == DismissDirection.endToStart){
              deleteProduct(index);
            }
          },
          child: Column(children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(products[index].image),
            ),
            title: Text(products[index].title),
            subtitle: Text('\$${products[index].price.toString()}'),
            trailing: _buildIconbtn(context, index),
          ),
          Divider(),
        ]),);
      },
      itemCount: products.length,
    );
  }
}
