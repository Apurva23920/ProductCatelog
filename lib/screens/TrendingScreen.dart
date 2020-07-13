import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:Product_Catalog/models/Product.dart';
import 'package:Product_Catalog/widgets/TrendingItem.dart';


class IsTrending extends StatefulWidget {
  IsTrending({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IsTrendingState createState() => _IsTrendingState();
}

class _IsTrendingState extends State<IsTrending> {
  // GraphQL query to be fetched
  String getProduct = """
  query{
  product(where: {isTrending: {_eq: true}}) {
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

 List<Product> productList;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Running the Query in this widget
        child: new Query(
          options: QueryOptions(
            documentNode: gql(getProduct),
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
            
            ProductList tl =
                ProductList.fromResponse(result.data['product']);
              
            
                
            
            return Column(
              children:<Widget>[
              Padding(
                padding: EdgeInsets.all(8),
              child: Row(children: <Widget>[
                Padding(padding: EdgeInsets.all(4),
                child: Icon(Icons.trending_up),
                ),
                Padding(padding: EdgeInsets.all(4),
                child: Text('Trending',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                ),
              ],
              ),
              ),

              Container(
                height:280,
              child:ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: tl.products.length,
                itemBuilder: (context, index) {
                  
                  final product = tl.products[index];

                 
                  return TrendingItem(product: product,);
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