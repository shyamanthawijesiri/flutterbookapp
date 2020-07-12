import 'package:first_app/models/product.dart';
import 'package:first_app/pages/product_edit.dart';
import 'package:first_app/scope-model/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;
  ProductListPage(this.model);
  // final List<Product> products;
  // final Function updateProduct;
  // final Function deleteProduct;
  // ProductListPage(this.products, this.updateProduct, this.deleteProduct);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductListPageState();
  }
}
class _ProductListPageState extends State<ProductListPage>{
@override
  initState(){
    widget.model.fetchProduct();
    super.initState();
  }

Widget _buildIconbtn(BuildContext context , int index, MainModel model){

    return IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  model.selectProduct(model.allProducts[index].id);
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
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      return  ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(model.allProducts[index].title),
          background: Container(color:Colors.red),
          onDismissed: (DismissDirection direction){
            if(direction == DismissDirection.endToStart){
              model.selectProduct(model.allProducts[index].id);
              model.deleteProduct();
            }
          },
          child: Column(children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(model.allProducts[index].image),
            ),
            title: Text(model.allProducts[index].title),
            subtitle: Text('\$${model.allProducts[index].price.toString()}'),
            trailing: _buildIconbtn(context, index, model),
          ),
          Divider(),
        ]),);
      },
      itemCount: model.allProducts.length,
    );
    });
  }
}
