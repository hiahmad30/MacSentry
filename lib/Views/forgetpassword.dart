import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macsentry/Controllers/AuthController.dart';

import '../constants.dart';

class forgetpassword extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ////////////////////////////////////----------------------------

  bool _autoValidate = false;
  String emailfp;
  ///////////////////////////////////--------------------------------
  TextEditingController emailControllerfp = TextEditingController();
  //////////////////////////////////---------------------------------
  final _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyResources.backgroundColor,
      appBar: AppBar(
        title: Container(
          child: Text(
            'Verification',
            style: GoogleFonts.roboto(),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 0),
                child: Container(
                  child: Image.asset(
                    "assets/logo.png",
                    width: 300,
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Text(
                    "Forgot Password?",
                    style: MyResources.appHeadingStyleLogin,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                child: Text(
                  "Enter the email address associated with your account.",
                  style: MyResources.appTextStyle,
                ),
              ),
              Padding(
                //Add padding around textfield
                padding: EdgeInsets.only(top: 25.0, left: 10, right: 10),
                child: TextFormField(
                  controller: emailControllerfp,
                  //Email Controller
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val.length == 0)
                      return "Please enter email";
                    else if (!val.contains("@"))
                      return "Please enter valid email";
                    else
                      return null;
                  },
                  onSaved: (val) => emailfp = val,
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
                padding: EdgeInsets.only(top: 50.0, left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      "Send Verification Code",
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        //  Get.to(VerificationCode());
                        await _authController
                            .sendpasswordresetemail1(emailControllerfp.text);
                      }
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
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
