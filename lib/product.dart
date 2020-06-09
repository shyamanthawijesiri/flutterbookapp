import 'package:first_app/pages/product.dart';
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
  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product[index]['image']),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(product[index]['title'],
                  style: TextStyle(fontSize: 30),
              ),
              SizedBox(width: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                 child:Text(//'\$'+product[index]['price'].toString()
                          '\$${product[index]['price'].toString()}'              
                    ),
                
              )
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
                        context, '/product/' + index.toString())
                //     .then((bool value) {
                //   if (value) {
                //     deleteProduct(index);
                //   }
                //   print(value);
                // }),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
               onPressed: () => Navigator.pushNamed<bool>(
                        context, '/product/' + index.toString()))
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
