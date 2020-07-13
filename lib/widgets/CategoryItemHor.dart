import 'package:Product_Catalog/screens/CategoryProductScreen.dart';
import 'package:Product_Catalog/screens/CategoryScreenVert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/Category.dart';

class CategoryItemHor extends StatefulWidget {
  final Category category;

  CategoryItemHor({@required this.category});

  @override
  _CategoryItemHorState createState() => _CategoryItemHorState();
}

class _CategoryItemHorState extends State<CategoryItemHor> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(vertical: 2),
      child: GestureDetector(
        onTap: () {
          
          print("You have tapped on ${widget.category.name}");
          print(" tapped ${widget.category.id}");
          
          
        },
        child: Container(
          width: 50,
          height: 50,
          child: Column(
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.only(top: 5),
              child:Stack(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                     
                      
                      image: DecorationImage(
                          image: NetworkImage(  widget.category.imgURL ??
                              'https://graphql.org/users/logos/github.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.category.name,
                  style: TextStyle(fontSize: 14,color: Colors.grey[500]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}