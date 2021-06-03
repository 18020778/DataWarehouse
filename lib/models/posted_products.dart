import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';

class PostedProducts{
  User seller;
  Product product;

  setSeller(User seller){
    this.seller =  seller;
  }

  setProduct(Product product){
    this.product = product;
  }

  PostedProducts(this.seller, this.product);
}