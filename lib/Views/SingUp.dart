import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macsentry/Controllers/AuthController.dart';

import '../constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  String selectedPackage = "7 Days Free";
  /////////////////////////////////////GetX Controller///////////////////////////////////
  AuthController authController = new AuthController();

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
                      "Create Account",
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
                        return "Please enter email";
                      else if (!val.contains("@"))
                        return "Please enter valid email";
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: "Email",
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
                                      ),
                                    )
                                  : Container(child: Text("Hide")),
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
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyResources.backgroundColor,
                        border: Border.all(color: MyResources.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    //  color: myResources.backgroundColor,
                    width: Get.width,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: Text(""),
                        value: selectedPackage,
                        focusColor: Colors.blue,
                        elevation: 12,
                        items: [
                          DropdownMenuItem<String>(
                            child: Text('7 Days Free'),
                            value: '7 Days Free',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('14 Days Free'),
                            value: '14 Days Free',
                          ),
                        ],
                        onChanged: (String value) {
                          print(value);
                          setState(() {
                            selectedPackage = value;
                          });
                        },
                        hint: Text('Select Item'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 10, right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: MyResources.registerBtnColor,
                      child: Text(
                        "Create Account",
                        style: MyResources.appTextStyle,
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
