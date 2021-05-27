class Plants{
  String categoryId;
  String plantName;
  String plantId;
  String imageUrl;
  String getCategoryId(){
    return this.categoryId;
  }
  String getPlantName(){
    return this.plantName;
  }
  String getPlantId(){
    return this.plantId;
  }
  String getImageUrl(){
    return this.imageUrl;
  }

  Plants(
      {this.categoryId,
      this.plantName,
      this.plantId,
      this.imageUrl});
  factory Plants.fromJson(Map<String, dynamic> json) => Plants(
    categoryId : json['categoryId'],
    plantName  : json['plantName'],
    plantId    : json['plantId'],
    imageUrl   : json['imageUrl']
  );

}