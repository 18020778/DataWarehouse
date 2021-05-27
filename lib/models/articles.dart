import 'package:first_app/models/handBook.dart';
import 'package:first_app/models/user.dart';

class Articles{
  User author;
  handBook handbook;

  setAuthor(User author){
    this.author =  author;
  }

  setHandBook(handBook handBook){
    this.handbook = handBook;
  }

  Articles(this.author, this.handbook);
}