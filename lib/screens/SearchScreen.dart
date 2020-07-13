import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:Product_Catalog/models/Product.dart';
import 'package:Product_Catalog/widgets/TrendingItem.dart';

class SearchView extends StatefulWidget {

  final String search;
  SearchView(this.search);
  @override
  _SearchViewState createState() => _SearchViewState(search);
}

class _SearchViewState extends State<SearchView> {

 
  // GraphQL query to be fetched

  String getSearchProduct = """
 query(\$search:String!){
  product(where: {name: {_ilike: \$search}}) {
    ID
    name
    Images(limit: 1) {
      url
    }
    currency
    price
    rating
    ratingCount
    Seller {
      Name
    }
  }
}

 """;
 
 final String search;
  _SearchViewState(this.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Running the Query in this widget
        child: new Query(
          options: QueryOptions(
            documentNode: gql(getSearchProduct),
            variables:{
              'category':'%$search%',
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
                  return TrendingItem(product: product);
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