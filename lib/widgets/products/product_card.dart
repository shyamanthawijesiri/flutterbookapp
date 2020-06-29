import 'package:first_app/models/product.dart';
import 'package:first_app/scope-model/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import '../../models/product.dart';

class ProductCard extends StatelessWidget{

  final Product product;
  final int productIndex;

  ProductCard(this.product,this.productIndex);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(product.title,
                  style: TextStyle(fontSize: 30),
              ),
              SizedBox(width: 20.0),
              PriceTag(product.price.toString())
            ]
          ),
          Container(
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(color:Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0)
            ),
              child: Text('Horathepola, welpalla'),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Colors.purple,
                onPressed: () => Navigator.pushNamed<bool>(
                        context, '/product/' + productIndex.toString())
                //     .then((bool value) {
                //   if (value) {
                //     deleteProduct(index);
                //   }
                //   print(value);
                // }),
              ),
              ScopedModelDescendant(builder: (BuildContext context, Widget child, ProductsModel model){
                return  IconButton(
                icon: Icon(model.Products[productIndex].isFavourite ? Icons.favorite : Icons.favorite_border),
                color: Colors.red,
               onPressed: () {
                 model.selectProduct(productIndex);
                 model.toggleProductFavouriteStatus();
               },
               );
              })
            ],
          )
        ],
      ),
    );
  }
}