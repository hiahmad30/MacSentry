import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macsentry/Controllers/AuthController.dart';

import '../constants.dart';
import 'Login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  AuthController auth = new AuthController();
  /////////////////////////////////Controllers////////////////////////////////////////////////////////
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passConfirmController = TextEditingController();
///////////////////////////////////Pass Visibility//////////////////////////////
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _name;
  String _email;
  String pass;
  String cpass;
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
            'Sign up',
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
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    "Let's Get Started!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    "Create an Account to get all features ",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                //Add padding around textfield
                padding: EdgeInsets.only(top: 25.0, left: 10, right: 10),
                child: TextFormField(
                  controller: _nameController, //N
                  keyboardType: TextInputType.text,
                  validator: (String arg) {
                    if (arg.length < 3)
                      return 'Name must be more than 2 charater';
                    else
                      return null;
                  },
                  onSaved: (String val) {
                    _name = val;
                    print(_name);
                  }, // ame Controller
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: "Name",
                    hintStyle: MyResources.hintfontStyle,
                    prefixIcon: Icon(Icons.account_circle),
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
                  controller: _emailController,
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
                  onSaved: (val) => _email = val,

                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: "Email",
                    hintStyle: MyResources.hintfontStyle,
                    prefixIcon: Icon(Icons.email),
                    // errorStyle: TextStyle(fontSize: 6),

                    /*errorText:
                        GetUtils.isEmail(_emailController.text)? null
                        : "true",*/
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
                  keyboardType: TextInputType.text,
                  obscureText: !_passwordVisible1,
                  controller: _passController, //// pass Controller
                  validator: (val) {
                    if (val.length == 0) {
                      return ('Please enter password');
                    } else if (val.length <= 7) {
                      return ('Your password must be at least 8 characters long.');
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) => pass = val,
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: "Password",
                    hintStyle: MyResources.hintfontStyle,
                    suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible1 = !_passwordVisible1;
                          });
                        }),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
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
                  keyboardType: TextInputType.text,
                  obscureText: !_passwordVisible2,
                  controller: _passConfirmController,
                  validator: (val) {
                    if (val.length == 0) {
                      return ('Please enter password');
                    } else if (val != _passController.text) {
                      return ('Password not match');
                    }
                    return null;
                  },
                  onSaved: (val) => cpass = val,

                  //pass Confirmation controller
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: "Confirm Password",
                    hintStyle: MyResources.hintfontStyle,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible2
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible2 = !_passwordVisible2;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 55.0, left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 45,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      "SignUp",
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        // Get.to(
                        //   ProfileEdit(),
                        // );
                      }
                      await auth
                          .createUser(
                              _nameController.text,
                              _emailController.text,
                              _passConfirmController.text)
                          .then((value) {
                        // if ()

                        //  else
                        Get.snackbar("LoginError",
                            "User not created . please try again");
                      });
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account?",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            " Log in here",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue,
                            ),
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
