import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macsentry/Controllers/AuthController.dart';

import '../constants.dart';
import 'SingUp.dart';
import 'forgetpassword.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _pass;
  /////////////////////////////////////GetX Controller///////////////////////////////////
  AuthController authController = new AuthController();
  /////////////////////////////////Controllers////////////////////////////////////////////////////////
  TextEditingController _emailControllerlogin = TextEditingController();
  TextEditingController _passControllerlogin = TextEditingController();
///////////////////////////////////Pass Visibility//////////////////////////////
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  /////////////////////////////Validator

  bool validator = true;

///////////////////////////////////Firebase Auth////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyResources.backgroundColor,
      appBar: AppBar(
        title: Container(
          child: Text(
            'Login',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 0),
                child: Container(
                  child: Image.asset(
                    "assets/logo.png",
                    width: 150,
                    height: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                  child: Text(
                    "Welcome Back!",
                    style: MyResources.appHeadingStyleLogin,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    "Login to your existing account ",
                    style: MyResources.appTextStyle,
                  ),
                ),
              ),
              Padding(
                //Add padding around textfield
                padding: EdgeInsets.only(top: 15.0, left: 10, right: 10),
                child: TextFormField(
                  controller: _emailControllerlogin,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter email";
                    else if (!val.contains("@"))
                      return "Please enter valid email";
                    else
                      return null;
                  },
                  onSaved: (val) => _email = val,
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: "Email",
                    hintStyle: MyResources.hintfontStyle,
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                //Add padding around textfield
                padding: EdgeInsets.only(top: 15.0, left: 10, right: 10),
                child: TextFormField(
                  controller: _passControllerlogin,
                  validator: (val) {
                    if (val.length == 0) {
                      return ('Please enter password');
                    } else if (val.length <= 7) {
                      return ('your password must be atleast 7 chracters ');
                    }
                    return null;
                  },
                  onSaved: (val) => _pass = val,
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: "Password",
                    hintStyle: MyResources.hintfontStyle,
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(forgetpassword());
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 200.0),
                  child: Center(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        height: 1.5,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      "Login",
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        authController.signInwithEmail(
                            _emailControllerlogin.text,
                            _passControllerlogin.text);

                        // Get.to();
                      }
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    "Or ",
                    style: MyResources.appTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: MyResources.appTextStyle,
                      ),
                      MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: Text(
                            " Sign Up",
                            style: MyResources.appsignuploginlink,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
