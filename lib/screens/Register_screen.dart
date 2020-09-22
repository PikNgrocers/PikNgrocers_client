import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      backgroundColor: kRegisterBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Sign_in.png',
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: kRegisterBackgroundColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

                      SizedBox(
                        height: 20,
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
                              borderSide:
                                  BorderSide(color: kRegisterBackgroundColor),
                            ),
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: kRegisterBackgroundColor,
                              size: 15.0,
                            ),
                            labelStyle:
                                TextStyle(color: kRegisterBackgroundColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: kRegisterBackgroundColor),
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
                              borderSide:
                                  BorderSide(color: kRegisterBackgroundColor),
                            ),
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kRegisterBackgroundColor,
                              size: 15.0,
                            ),
                            labelStyle:
                                TextStyle(color: kRegisterBackgroundColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: kRegisterBackgroundColor),
                            )),
                        showCursor: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formkey.currentState.validate()) {}
                        },
                        padding: EdgeInsets.all(0),
                        color: kRegisterBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textColor: Colors.white,
                        child: Text(
                          'Register',
                        ),
                      ),
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
