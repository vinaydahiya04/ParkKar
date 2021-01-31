import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:park_kar/Network/UserRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(454, 969), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xFFf2f7fc),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 7,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          child: Image.asset(
                            "images/logo.png",
                          ),
                        ),
                      ),
                      Container(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        child: TextField(
                          obscureText: true,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blueGrey[600],
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFDedeff1),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });

                            try {
                              final isRegistered = await UserAuth()
                                  .registerRequest(
                                      nameController.text,
                                      phoneController.text,
                                      emailController.text,
                                      passwordController.text);
                              if (isRegistered == true) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              print(e);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
