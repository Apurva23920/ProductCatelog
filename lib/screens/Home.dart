import 'package:Product_Catalog/screens/CategoryScreenHor.dart';
import 'package:Product_Catalog/screens/FeaturedScreen.dart';
import 'package:Product_Catalog/screens/SearchScreen.dart';
import 'package:Product_Catalog/screens/TrendingScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchText;
  
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon:Image.asset('assets/Group_342.png',
        ), 
        onPressed: null,
      ),
        
      title:Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      child:Container(
        height: 35,
        child:TextField(
          onChanged: (value) {
            searchText=value;
          },
          onTap:(){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchView(searchText)));
            // search mech
          } ,
           style: TextStyle(color: Colors.grey, ),
           decoration: InputDecoration(
             prefixIcon: Icon(Icons.search),
             hintText: "Search...",
             
             ),
          ),
        
          ),
          ),
       centerTitle: true,
       actions: <Widget>[
         Container(
    
       child:Card(
         elevation: 5,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
       child:IconButton(icon: Icon(Icons.crop_free),onPressed: null,)
         ),
         ),
         ],
    ),
     body: ListView(
        controller: ScrollController(initialScrollOffset: 0,keepScrollOffset: true),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            height: 120,
          child:CategoryViewHor(),
          ),
          Container(
            height: 328,
            child: IsTrending()),
          Container(
            height: 378,
            child: IsFeatured(),
          )
      
        ],

     ),
        

        
      
      
     
     );

    
  }
}