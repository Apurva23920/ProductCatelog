class Product {
  String name;
  String id;
  String url;
  String currency;
  var price;
  var rating;
  var ratingCount;

  Product({this.url, this.name, this.id, this.currency, this.price, this.rating, this.ratingCount});

  factory Product.fromJson(Map<String, dynamic> result){
   
    return Product(url:result['Images']['url'],
    name:result['name'],
    id: result['ID'],
    currency: result['currency'],
    price: result['price'], 
    rating:result['rating'], 
    ratingCount:result['ratingCount'], );
  }
}

class ProductList{
  List<Product> products;
  ProductList(this.products);

  factory ProductList.fromResponse(List<dynamic> list){
  List<Product> temp = List<Product>();
    list.forEach((item) {
      temp.add(
        Product(
        id:item['ID'], 
        name:item['name'],
        url:  item['Images'][0]['url'],
        currency:item['currency'], 
        price:item['price'],
        rating: item['rating'], 
        ratingCount:item['ratingCount']));
    });
    return ProductList(temp);
  }
}
