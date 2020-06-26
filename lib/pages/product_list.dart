import 'package:first_app/models/product.dart';
import 'package:first_app/pages/product_edit.dart';
import 'package:first_app/scope-model/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  // final List<Product> products;
  // final Function updateProduct;
  // final Function deleteProduct;
  // ProductListPage(this.products, this.updateProduct, this.deleteProduct);

Widget _buildIconbtn(BuildContext context , int index, ProductsModel model){

    return IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  model.selectProduct(index);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      // return ProductEditPage(
                      //   product: products[index],
                      //   updateProduct: updateProduct,
                      //   productIndex: index,
                      // );
                      return ProductEditPage();
                    }),
                  );
                });

  
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<ProductsModel>(builder: (BuildContext context, Widget child, ProductsModel model){
      return  ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(model.Products[index].title),
          background: Container(color:Colors.red),
          onDismissed: (DismissDirection direction){
            if(direction == DismissDirection.endToStart){
              model.selectProduct(index);
              model.deleteProduct();
            }
          },
          child: Column(children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(model.Products[index].image),
            ),
            title: Text(model.Products[index].title),
            subtitle: Text('\$${model.Products[index].price.toString()}'),
            trailing: _buildIconbtn(context, index, model),
          ),
          Divider(),
        ]),);
      },
      itemCount: model.Products.length,
    );
    });
  }
}
