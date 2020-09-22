import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoginBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                  width: 150,
                  height: 150,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: kLoginBackgroundColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Image.asset(
                        "assets/images/Login_re.png",
                        fit: BoxFit.fill,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (val) =>
                            val.isEmpty ? "Email address is Empty" : null,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                        autocorrect: true,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kLoginBackgroundColor),
                            ),
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: kLoginBackgroundColor,
                              size: 15.0,
                            ),
                            labelStyle: TextStyle(color: kLoginBackgroundColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: kLoginBackgroundColor),
                            )),
                        showCursor: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        validator: (val) =>
                            val.isEmpty ? "Password should not Empty" : null,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                        autocorrect: true,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kLoginBackgroundColor),
                            ),
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kLoginBackgroundColor,
                              size: 15.0,
                            ),
                            labelStyle: TextStyle(color: kLoginBackgroundColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: kLoginBackgroundColor),
                            )),
                        showCursor: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            Navigator.pushNamed(context, '/home');
                          }
                        },
                        padding: EdgeInsets.all(0),
                        color: kLoginBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textColor: Colors.white,
                        child: Text(
                          'Login',
                        ),
                      ),
                      FlatButton(
                        onPressed: null,
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Forget Password',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: (){
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              color: kLoginBackgroundColor,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
