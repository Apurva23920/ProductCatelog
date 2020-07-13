import 'package:Product_Catalog/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:Product_Catalog/models/Category.dart';
import 'package:Product_Catalog/widgets/CategoryItemVert.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class CategoryView extends StatefulWidget {
  CategoryView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
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
      appBar: AppBar(
        title: Text('Categories',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
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
            return Container(
              
              child:Column(
              children:<Widget>[
                Container(
                  height:500 ,
              child:ListView.builder(
                itemCount: cl.categories.length,
                itemBuilder: (context, index) {
                  // Category Object contains the name & url of category
                  final category = cl.categories[index];

                  // Showing custom item ui for a particular category
                  return CategoryItem(category: category);
                }
                ),
                ),
                Container(
                  height: 20,
                  child: IconButton(icon: Icon(Icons.expand_less),
                   onPressed:(){  Navigator.pop(context);
                   }
                   ),
                ),
              ],
            ),
              );
          },
        ),
      ),
    );
  }
}