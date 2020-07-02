import 'package:first_app/models/product.dart';
import 'package:first_app/scope-model/main.dart';
//import 'package:first_app/scope-model/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../product_manager.dart';
import './products_admin.dart';
import '../widgets/products/product.dart';

class ProductsPage extends StatefulWidget {
 final MainModel model;
 ProductsPage(this.model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductsPageState();
  }
}
class _ProductsPageState extends State<ProductsPage>{
// final List<Product> product;
// // final Function addProduct;
// // final Function deleteProduct;

// ProductsPage(this.product);
//ProductsPage(this.product, this.addProduct, this.deleteProduct);
@override
initState(){
  widget.model.fetchProduct();
super.initState();
}
  Widget _buildSlideDrawer(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('Choose'),
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Product'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/admin');
          },
        )
      ],
    ));
  }
  Widget _buildProductsList(){
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      Widget content = Center(child: Text('No Product'),);
      if(model.displayProducts.length>0 &&  !model.isLoading){
        content = Products();
      }else if(model.isLoading){
        content = Center(child:CircularProgressIndicator()); 

      }
      return content;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: _buildSlideDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(builder:
              (BuildContext context, Widget child, MainModel model) {
                return IconButton(
                  icon: Icon(model.displayFavouriteOnly ? Icons.favorite : Icons.favorite_border), 
                  onPressed: () {
                      model.toggleDisplayMode();
                  },);
          })
        ],
      ),
      // body: ProductManager(product,addProduct,deleteProduct),
      body: _buildProductsList(),
    );
  }
}
