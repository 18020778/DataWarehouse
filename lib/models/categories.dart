class Categories{
  String categoryID;
  String categoryName;
  String imageUrl;
  Categories({this.categoryID, this.categoryName, this.imageUrl});

  // load Json to Object
  String getCategoryName(){
    return this.categoryName;
  }
  String getCategoryId(){
    return this.categoryID;
  }
  String getImageUrl(){
    return this.imageUrl;
  }

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    categoryID : json['categoryId'],
    categoryName : json['categoryName'],
    imageUrl : json['imageUrl']
  );
}