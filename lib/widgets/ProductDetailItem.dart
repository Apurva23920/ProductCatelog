import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Product_Catalog/models/Product.dart';

class TrendingItem extends StatefulWidget {
  
  final Product product;
  TrendingItem({@required this.product});

  
  @override
  _TrendingItemState createState() => _TrendingItemState();
}

class _TrendingItemState extends State<TrendingItem> {
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
                    height: 120,
                    width: 120,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                  Container(
                    width: 400,
                    height:400,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(widget.product.url ??
                              'https://graphql.org/users/logos/github.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                 

                  
                ],
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 6,left: 8),
                child: Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 20),
                ),
              ),

              //features

              //reviews

              //seller

           Container(
             color: Colors.black87,
             padding: EdgeInsets.all(10),
                child:Row(
                  children: <Widget>[
                    Column( 
                      children: <Widget>[
                      Row(
                        children: <Widget>[
                        Container(
                          color: Colors.white,
                          child:Text(
                            widget.product.currency,
                            style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white) 
                          )
                        ),

                        Container(
                          color: Colors.white,
                          child:Text(
                            widget.product.price.toString(),
                            style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white) 
                          )
                        ),
                      ],
                      ),
                      
                      Row(
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
                      ],
                    
              ),
                  
                   Positioned(
                    right: 0,
                    bottom: 0,
                     child: Container(
                       color: Colors.yellow[700],
                       child: RaisedButton(child: Text('Buy Now',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                       onPressed: null,
                       ),
                     ),
                  ),
                  ],
                ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}