import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:Product_Catalog/models/Product.dart';
import 'package:Product_Catalog/widgets/FeaturedItem.dart';


class IsFeatured extends StatefulWidget {
  IsFeatured({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IsFeaturedState createState() => _IsFeaturedState();
}

class _IsFeaturedState extends State<IsFeatured> {
  // GraphQL query to be fetched
  String getFProduct = """
  query{
  product(where: {isFeatured: {_eq: true}},limit:4) {
    ID
    name
    Images(limit: 1) {
      url
    }
    currency
    price
    rating
    ratingCount
  }
}

""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        // Running the Query in this widget
        child: new Query(
          options: QueryOptions(
            documentNode: gql(getFProduct),
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
            // Casting the Categories into CategoryList Object present in Category.dart
            ProductList fl =
                ProductList.fromResponse(result.data['product']);
                
            // Displaying the ListView on successful response
            return Column(
              children:<Widget>[
              Padding(
                padding: EdgeInsets.all(8),
              child: Row(children: <Widget>[
                Padding(padding: EdgeInsets.all(4),
                child: Icon(Icons.shopping_basket),
                ),
                Padding(padding: EdgeInsets.all(4),
                child: Text('Featured Listings',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                ),
              ],
              ),
              ),

              Container(
                height:322,
              child:ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(keepScrollOffset: true,initialScrollOffset: 0,),
                itemCount: fl.products.length,
                itemBuilder: (context, index) {
                  // Category Object contains the name & url of category
                  final product = fl.products[index];

                  // Showing custom item ui for a particular category
                  return FeaturedItem(product: product);
                }
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