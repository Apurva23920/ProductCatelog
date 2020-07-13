import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:Product_Catalog/models/Product.dart';
import 'package:Product_Catalog/widgets/CategoryProductItem.dart';


class CategoryProductView extends StatefulWidget {
  
  


  @override
  _CategoryProductViewState createState() => _CategoryProductViewState();
}

class _CategoryProductViewState extends State<CategoryProductView> {

 
  // GraphQL query to be fetched

  String getCategoryProduct = """
  query(\$category: uuid!){ 
      product(where: {Category: {ID: {_eq: \$category}}}) { 
        ID 
        name 
        Images(limit: 1) {  url } 
        currency 
        price 
        rating 
        ratingCount   
        } } 
 """;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Running the Query in this widget
        child: new Query(
          options: QueryOptions(
            documentNode: gql(getCategoryProduct),
            variables:{
              'category':'8c05d03c-9f1b-4ea1-89bf-6cfe5534fac5',
            }, 
            pollInterval: 10,
            
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              // error connecting to server
              print(result.exception.toString());
              return Text("Error Connecting to server!");
            }

            if (result.loading) {
              // getting data from the server
              return CircularProgressIndicator();
            }
            
            ProductList cpl =
            ProductList.fromResponse(result.data['product']);
            // Displaying the ListView on successful response
            return Column(
              children:<Widget>[
              Padding(
                padding: EdgeInsets.all(8),
              child: Row(children: <Widget>[
                Padding(padding: EdgeInsets.all(4),
                child: Icon(Icons.trending_up),
                ),
                Padding(padding: EdgeInsets.all(4),
                child: Text(' abcd',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                ),
              ],
              ),
              ),

              Container(
                height:280,
                child:GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(initialScrollOffset: 0,keepScrollOffset: true),
                  itemCount: cpl.products.length,
                  itemBuilder: (context, index) {
                  // Category Object contains the name & url of category
                  final product = cpl.products[index];
                  // Showing custom item ui for a particular category
                  return CategoryProductItem(product: product);
                },
                ),
              
                ),
            ],
              );
          },
        ),
      ),
    );
  }
}