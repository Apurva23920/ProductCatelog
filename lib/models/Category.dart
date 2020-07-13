class Category {
  String name;
  String imgURL;
  var id;
  Category(this.id,this.name, this.imgURL);

  factory Category.fromResults(Map<String, dynamic> result){
    return Category( result['ID'],result['Category_name'], result['Category_url']);
  }
}

class CategoryList{
  List<Category> categories;

  CategoryList(this.categories);

  factory CategoryList.fromResponse(List<dynamic> list){
    List<Category> temp = List<Category>();
    list.forEach((item) {
      temp.add(Category(item['ID'], item['Category_name'], item['Category_url']));
    });
    return CategoryList(temp);
  }
}

