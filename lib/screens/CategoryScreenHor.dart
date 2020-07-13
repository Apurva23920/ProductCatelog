import 'package:Product_Catalog/screens/CategoryScreenVert.dart';
import 'package:flutter/material.dart';
import 'package:Product_Catalog/models/Category.dart';
import 'package:Product_Catalog/widgets/CategoryItemHor.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class CategoryViewHor extends StatefulWidget {
  CategoryViewHor({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CategoryViewHorState createState() => _CategoryViewHorState();
}

class _CategoryViewHorState extends State<CategoryViewHor> {
  // GraphQL query to be fetched
  String getCategories = """
  query {
    Category{
      ID
      Category_name
      Category_url
    }
  }
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Running the Query in this widget
        child: Query(
          options: QueryOptions(
            documentNode: gql(getCategories),
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
            CategoryList cl =
                CategoryList.fromResponse(result.data['Category']);
            // Displaying the ListView on successful response
            return Card(
              elevation: 7,
              child:Container(
                height: 120,
              child:Row(
              children: <Widget>[
                Container(
                  width: 355,
                child:ListView.builder(
                  controller: ScrollController(initialScrollOffset: 0,keepScrollOffset:true ),
                  scrollDirection: Axis.horizontal,
                    itemCount: cl.categories.length,
                    itemBuilder: (context, index) {
                      // Category Object contains the name & url of category
                      final category = cl.categories[index];

                      // Showing custom item ui for a particular category
                      return CategoryItemHor(category: category);
                    }),),
                    Container(
                      width: 20,
                      height: 20,
                      
                  child:IconButton(icon: Icon(Icons.expand_more),
                   onPressed:(){
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryView()));
                     print(Text('Expand'));
                     },
                  ),),
              ],
            ),
              ),
            );
          },
        ),
      ),
    );
  }
}