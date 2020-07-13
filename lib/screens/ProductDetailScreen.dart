import 'package:Product_Catalog/models/productDetailData.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:Product_Catalog/models/Product.dart';
import 'package:Product_Catalog/widgets/TrendingItem.dart';


class ProductDetailPage extends StatefulWidget {
   
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State< ProductDetailPage> {
  // GraphQL query to be fetched
  String getProduct = """
 query (\$productID: uuid!) {   product(where: {ID: {_eq: \$productID}}) {     
   name     
   description     
   currency     
   price     
   rating     
   ratingCount     
   Images {       
     url     
     }     
   reviews {       
     name       
     profile_url       
     review       
     rating     
       }     
   product_tags{       
     tag{        
       tag 
      }     
      }     
   Seller {       
     Name       
     ID       
     seller_rating       
     seller_profile     
     }  
      } 
         } 

""";

 List<ProductDetailsData> productdetails;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Running the Query in this widget
        child: new Query(
          options: QueryOptions(
            documentNode: gql(getProduct),
            variables: {   "productID":"7e928b70-475b-4e23-9a5f-1ced7df856d2" } 
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
                child: Text('Product Details',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                ),
              ],
              ),
              ),

              Container(
                height:280,
              child:ListView.builder(
              scrollDirection: Axis.vertical,
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