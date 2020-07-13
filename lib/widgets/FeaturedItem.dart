
import 'package:Product_Catalog/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class FeaturedItem extends StatefulWidget {
  final Product product;

  FeaturedItem({@required this.product});

  @override
  _FeaturedItemState createState() => _FeaturedItemState();
}

class _FeaturedItemState extends State<FeaturedItem> {
  @override
  Widget build(BuildContext context) {

    
    
    return Container(
      width: 130,
      margin: EdgeInsets.symmetric(vertical: 2),
      child: GestureDetector(
        onTap: () {
          print("You have tapped on ${widget.product.name}");
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 7,
                child:Stack(
                children: <Widget>[
                  Container(
                    height: 126,
                    width: 120,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                  Container(
                    width: 110,
                    height:116,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(widget.product.url ??
                              'https://graphql.org/users/logos/github.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child:Row(children: <Widget>[
                    Container(
                      color: Colors.white,
                      child:Text(
                        'Rs.',
                        style:TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.yellow) 
                      )
                    ),

                    Container(
                      color: Colors.white,
                      child:Text(
                        widget.product.price.toString(),
                        style:TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.yellow) 
                      )
                    ),
                  ],))

                  
                ],
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 15),
                ),
              ),

            Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[

                    if(widget.product.rating<3)
                  Icon(Icons.star,
                      color: Colors.red),
                    
                    if(widget.product.rating<=4 && widget.product.rating>=3)
                  Icon(Icons.star,
                      color: Colors.yellow),
                  
                  
                    if(widget.product.rating>4 )
                  Icon(Icons.star,
                      color: Colors.green[300]),
                  
                  Text(
                     widget.product.rating.toString(),
                    style: TextStyle(fontSize: 14),
                  ),

                  Text(
                    '(',
                    style: TextStyle(fontSize: 14),
                  ),

                  Text(
                    widget.product.ratingCount.toString(),
                    style: TextStyle(fontSize: 14),
                  ),

                  Text(
                    ')',
                    style: TextStyle(fontSize: 14),
                  ),
                
                
                ],
                ),
              )
            
            ],
          ),
        ),
      ),
    );
  }
}