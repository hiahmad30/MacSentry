import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macsentry/Controllers/AuthController.dart';
import 'package:macsentry/Controllers/VpnController.dart';
import 'package:macsentry/Views/HomeDrawer.dart';

import '../constants.dart';
import 'SingUp.dart';
import 'forgetpassword.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  /////////////////////////////////////GetX Controller///////////////////////////////////
  final authController = Get.put(AuthController());
  final vpnController = Get.put(MSVpnController());

  /////////////////////////////////Controllers////////////////////////////////////////////////////////
  TextEditingController _emailControllerlogin = TextEditingController();

  TextEditingController _passControllerlogin = TextEditingController();

///////////////////////////////////Pass Visibility//////////////////////////////
  bool _passwordVisible1 = true;

  /////////////////////////////Validator

  bool validator = true;

///////////////////////////////////Firebase Auth////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyResources.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Text(
                      "Log In",
                      style: MyResources.appHeadingStyle,
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
                        return "Please enter User ID";
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: "User",
                      hintStyle: MyResources.hintfontStyle,

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
                    obscureText: _passwordVisible1,
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: "Password",
                      hintStyle: MyResources.hintfontStyle,
                      fillColor: MyResources.loginBtnColor,

                      suffix: InkWell(
                          child:
                              // Based on passwordVisible state choose the icon
                              _passwordVisible1
                                  ? Container(
                                      child: Text(
                                      "Show",
                                      style: TextStyle(
                                          color: MyResources.loginBtnColor),
                                    ))
                                  : Container(
                                      child: Text(
                                      "Hide",
                                    )),
                          onTap: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible1 = !_passwordVisible1;
                            });
                          }),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 10, right: 10),
                  child: Container(
                    width: Get.width * 0.9,
                    height: 50,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: MyResources.loginBtnColor,
                      child: Text(
                        "Log In",
                        style: MyResources.appTextStyle,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await vpnController
                              .connectVpn(_emailControllerlogin.text,
                                  _passControllerlogin.text)
                              .then((value) async {
                            await vpnController.getCred();
                            Get.back();
                            Get.off(HomeDrawer());
                          });
                        }
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //   Get.to(forgetpassword());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Center(
                      child: Text(
                        "Forgot your Password?",
                        style: TextStyle(
                          color: MyResources.loginBtnColor,
                          height: 1.5,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100.0, left: 10, right: 10),
                  child: Container(
                    width: Get.width * 0.9,
                    height: 50,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: MyResources.registerBtnColor,
                      child: Text(
                        "Create Account",
                      ),
                      onPressed: () {
                        Get.to(SignUpPage());
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(40.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
