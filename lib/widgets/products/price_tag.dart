import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget{

  final String price;
  PriceTag(this.price);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return    Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                 child:Text(//'\$'+product[index]['price'].toString()
                          '\$$price'              
                    ),
                
              );
  }
}