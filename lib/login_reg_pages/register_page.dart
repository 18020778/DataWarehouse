import 'package:first_app/login_reg_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String phoneNumber;
  String userName;
  String email;
  String password;
  String confirmPass;
  String verificationCode;
  String smsCode;
  final txt = TextEditingController();
  clearTextInput(){
    txt.clear();
  }
  final regex = RegExp(r'[a-zA-Z0-9]+$');
  final formKey = new GlobalKey<FormState>();
  void validate(){
    final form = formKey.currentState;
    if(form.validate()){
      _verifyPhone();
      print("hello");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green[900],
            ),
            child: Column(
                children: <Widget>[
                  //Image.asset('assets/logo.png', width: 180, height: 180,),
                  SizedBox(height: 50),
                  Text('Welcome to Little Garden!',
                    style: TextStyle(
                      fontFamily: 'AkayaTelivigala',
                      color: Colors.lime,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      child:  Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            _textInput(hint: "Name", icon: Icons.account_circle),
                            _textInput(hint: "Phone Number",  icon: Icons.phone),
                            _textInput(hint: "Email", icon: Icons.email),
                            _textInput(hint: "Password", icon: Icons.vpn_key),
                            _textInput(hint: "Confirm Password", icon: Icons.vpn_key),

                          ],
                        ),
                      )
                  ),
                  SizedBox(height: 40,),
                  Flexible(
                    child: SizedBox(
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(130, 12, 130, 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          onPressed: (){
                            validate();
                            //(context);

                          },
                          child: Text("REGISTER",
                            style: TextStyle(
                              fontSize: 20,
                            ),),
                        )
                    ),
                  ),
                  SizedBox(height: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a member?  ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
                        },
                        child: Text("Login now",
                          style: TextStyle(color: Colors.lime, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ]
            )
        )
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.white),
            left: BorderSide(width: 1.0, color: Colors.white),
          )
      ),
      child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 20, color: Colors.white70),
              prefixIcon: Icon(icon,color: Colors.white,),
              errorStyle: TextStyle(fontSize: 15, color: Colors.white30)
          ),
          onChanged: (val){
            getValue(hint, val);
          },
          validator: (val) => val.isEmpty ? hint + " cant't be empty" : (hint == "Confirm Password" ? (this.password != this.confirmPass ? "Password not match" : null):null)
      ),
    );
  }

  void getValue(String hint, String val){
    if(hint == "Name") this.userName = val;
    else if (hint == "Phone Number"){
      if(val[0] == "0"){
        this.phoneNumber = "+84" + val.substring(1, val.length);
      }
    }else if (hint == "Email") this.email = val;
    else if (hint ==  "Password") this.password = val;
    else this.confirmPass = val;
  }


  Future <void> _verifyPhone() async {
    // Automatic handling of the SMS code on Android devices
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) async{

      await FirebaseAuth.instance.signInWithCredential(credential);
    };


    // Handle failure events : invalid phoneNumber, ...
    final PhoneVerificationFailed phoneVerificationFailed = (AuthException exception){
      print("${exception.message}");
    };

    // Handle when a code has been sent to the sevice form Firebase
    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]){
      this.verificationCode = verId;
      smsCodeDialog(context).then((value)=>
      {
        print("Signed In")
      }
      );

    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId){
      this.verificationCode = verId;
    };


    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<bool> smsCodeDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Enter Code",
              style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 20
              ),),
            content: TextField(
              controller: txt,
              onChanged: (val){
                smsCode = val;
                if(val.length ==6)
                {
                  FirebaseAuth.instance.currentUser().then((user){
                    if(user!=null){
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => loginPage()));
                    }else{
                      Navigator.of(context).pop();
                      signIn();
                      // clearTextInput();
                      clearTextInput();
                    }
                  });
                }
              },
              autofocus: true,
              maxLength: 6,
              style: TextStyle(
                color: Colors.green[700],
                fontSize: 30,
                letterSpacing: 23,

              ),
            ),
          );
        }
    );
  }

  signIn(){
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(verificationId: verificationCode, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((user)=> Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginPage()),
    )).catchError((e)=>print(e));
  }

}