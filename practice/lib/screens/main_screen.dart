import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/config/palette.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  bool isSignupScreen = false;
  Duration duration = Duration(milliseconds: 500);
  Curve curve = Curves.easeIn;

  final _formKey = GlobalKey<FormState>();

  String _userName = '';
  String _email = '';
  String _password = '';

  var _spinner = false;

  void _buttonClicked() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (isSignupScreen) {
        try {
          setState(() {
            _spinner = true;
          });
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          if (newUser.user != null) {
            await _store.collection('user').doc(newUser.user!.uid).set(
              {
                'userName': _userName,
                'email': _email,
              },
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
          print(e);
          setState(() {
            _spinner = false;
          });
        }
      } else {
        try {
          setState(() {
            _spinner = true;
          });
          await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
          print(e);
          setState(() {
            _spinner = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: ModalProgressHUD(
          inAsyncCall: _spinner,
          child: Stack(
            children: [
              // 배경
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, top: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Welcome ',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: isSignupScreen ? 'to my chat!' : 'back',
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          isSignupScreen
                              ? 'Signup to continue'
                              : 'Signin to continue',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            // fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // 텍스트 폼 필드
              Positioned(
                top: 180,
                child: AnimatedContainer(
                  duration: duration,
                  curve: curve,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5,
                        )
                      ]),
                  height: isSignupScreen ? 280 : 250,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Text(
                                'LOGIN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: !isSignupScreen
                                        ? TextDecoration.underline
                                        : null,
                                    decorationColor: Colors.orange,
                                    decorationThickness: 2.0,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Text(
                                'SIGNUP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: isSignupScreen
                                      ? TextDecoration.underline
                                      : null,
                                  decorationColor: Colors.orange,
                                  decorationThickness: 2.0,
                                  color: isSignupScreen
                                      ? Palette.activeColor
                                      : Palette.textColor1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (isSignupScreen)
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            margin: EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  MyTextFormField(
                                    key: ValueKey(1),
                                    icon: Icons.account_circle,
                                    hintText: 'User name',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'The name cannot be empty';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        _userName = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 8),
                                  MyTextFormField(
                                    key: ValueKey(2),
                                    icon: Icons.email,
                                    hintText: 'Email',
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !EmailValidator.validate(value)) {
                                        return 'The email address is not valid';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(
                                        () {
                                          _email = value!;
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(height: 8),
                                  MyTextFormField(
                                    key: ValueKey(3),
                                    icon: Icons.lock,
                                    hintText: 'Password',
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'The password cannot be empty and should be at least 6 characters long';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(
                                        () {
                                          _password = value!;
                                        },
                                      );
                                    },
                                    onFieldSubmitted: (value) {
                                      _buttonClicked();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  MyTextFormField(
                                    key: ValueKey(4),
                                    icon: Icons.email,
                                    hintText: 'Email',
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !EmailValidator.validate(value)) {
                                        return 'The email address is not valid';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(
                                        () {
                                          _email = value!;
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(height: 8),
                                  MyTextFormField(
                                    key: ValueKey(5),
                                    icon: Icons.lock,
                                    hintText: 'Password',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'The password cannot be empty';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(
                                        () {
                                          _password = value!;
                                        },
                                      );
                                    },
                                    onFieldSubmitted: (value) {
                                      _buttonClicked();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // 로그인 버튼
              AnimatedPositioned(
                duration: duration,
                curve: curve,
                top: isSignupScreen ? 430 : 400,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: GestureDetector(
                      onTap: () async {
                        _buttonClicked();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange,
                              Colors.red,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 구글 로그인 버튼
              Positioned(
                top: MediaQuery.of(context).size.height - 125,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text('or Signup with'),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      label: Text('Google'),
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          minimumSize: Size(155, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Palette.googleColor),
                      icon: Icon(Icons.add),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.validator,
    required this.onSaved,
    this.onFieldSubmitted,
  });

  final IconData icon;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
          contentPadding: EdgeInsets.all(10)),
      validator: validator,
      onSaved: onSaved,
      keyboardType: TextInputType.text,
      onFieldSubmitted: onFieldSubmitted ?? (value) {},
    );
  }
}
