// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:first_app/pages/login_page.dart';
// import 'package:first_app/services/database.dart';
// import 'package:flutter/material.dart';
// import 'package:first_app/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class regPassword extends StatefulWidget {
//   User user;
//   @override
//   _regPasswordState createState() => _regPasswordState();
//   regPassword({this.user});
// }
//
// class _regPasswordState extends State<regPassword> {
//   String pass;
//   String rePass;
//   bool _obscureText = true;
//   final formKey = new GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 70,
//           title: Text('Mật khẩu',
//             style: TextStyle(fontSize: 22),),
//           backgroundColor: Colors.green[900],
//         ),
//         body: Form(key: formKey,child:
//
//         Column(
//             children:<Widget> [
//               SizedBox(height: 60,),
//               Text('Nhập mật khẩu của bạn',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 textAlign: TextAlign.center,),
//               SizedBox(height: 20,),
//               Container(
//                 margin: EdgeInsets.fromLTRB(40, 0, 40, 25),
//                 decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(width: 1.0, color: Colors.blue),
//                     )
//                 ),
//                 child: TextFormField(
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                   decoration: InputDecoration(
//                     hintText: ('Mật khẩu'),
//                     hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureText ? Icons.visibility_off : Icons.visibility
//                       ),
//                       onPressed: (){
//                         _toggle();
//                       },
//                     )
//                   ),
//                   autofocus: true,
//                   onChanged: (val){
//                     this.pass = val;
//                   },
//                   obscureText: _obscureText,
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(40, 0, 40, 40),
//                 decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(width: 1.0, color: Colors.blue),
//                     )
//                 ),
//                 child: TextFormField(
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                   decoration: InputDecoration(
//                     hintText: ('Nhập lại mật khẩu'),
//                     hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                             _obscureText ? Icons.visibility_off : Icons.visibility
//                         ),
//                         onPressed: (){
//                           _toggle();
//                         },
//                       )
//                   ),
//                   obscureText: _obscureText,
//                   onChanged: (val){
//                     this.rePass = val;
//                   },
//                   validator: (val) => this.rePass == this.pass ? null:"Pass not match",
//                 ),
//               ),
//               Flexible(
//                   child: RaisedButton(
//                     color: Colors.green[800],
//                     padding: EdgeInsets.fromLTRB(140, 12, 140, 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                     onPressed: () {
//                         if(formKey.currentState.validate()){
//                               widget.user.setPassword(this.pass);
//                               // create account in firestore
//                                     print(widget.user.userName);
//                                     print(widget.user.phoneNumber);
//                                     print(widget.user.password);
//                                     _signUp(widget.user);
//                               // navigator to Login page
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
//                         }
//                     },
//
//                     child: Text("REGISTER",
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white
//                       ),),
//                   )
//               ),
//             ]
//         )
//     ));
//   }
//   Future<String> _signUp(User user) async{
//     String _resultSignUp = await Database().createUser(user);
//     print(_resultSignUp);
//   }
//   void _toggle() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }
// }
