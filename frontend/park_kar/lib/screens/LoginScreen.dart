import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:park_kar/Network/SignUp.dart';
import 'package:park_kar/Network/UserRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController credController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showSpinner = false;

  // GoogleSignIn _googleSignIn = GoogleSignIn();
  // FirebaseAuth _auth;
  // bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    // await Firebase.initializeApp();
    // _auth = FirebaseAuth.instance;
    // await FirebaseAuth.instance.signOut();
    // await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(454, 969), allowFontScaling: false);
    return Scaffold(
      backgroundColor: Color(0xFFf2f7fc),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/loading.jpg'))),
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
                          child: Container(child: null),
                        ),
                        Container(
                          child: TextField(
                            controller: credController,
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
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blueGrey[600],
                            child: Text(
                              'Login',
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
                                user = await UserAuth().loginRequest(
                                    credController.text,
                                    passwordController.text);

                                if (user != null) {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('cred', credController.text);
                                  prefs.setString(
                                      'password', passwordController.text);
                                  print(user);
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
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: <Widget>[
                              Text(
                                'Do not have an account?',
                                style: TextStyle(fontSize: 15),
                              ),
                              FlatButton(
                                textColor: Colors.blue,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignUp(),
                                    ),
                                  );
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 300.w,
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        // Text(
                        //   'Or Login with',
                        //   textAlign: TextAlign.left,
                        //   style: TextStyle(fontSize: 18, color: Colors.black54),
                        // ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     setState(() {
                        //       showSpinner = true;
                        //     });
                        //
                        //     await signInWithGoogle();
                        //
                        //     setState(() {
                        //       showSpinner = false;
                        //     });
                        //   },
                        //   child: Image.asset(
                        //     'images/google.png',
                        //     height: 60.h,
                        //   ),
                        // )
                      ],
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

  // void signInWithGoogle() async {
  //   User userGoogleLoggedIn;
  //
  //   // await Firebase.initializeApp();
  //   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //
  //   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   userGoogleLoggedIn = (await _auth.signInWithCredential(credential)).user;
  //
  //   if (userGoogleLoggedIn != null) {
  //     assert(!userGoogleLoggedIn.isAnonymous);
  //     assert(await userGoogleLoggedIn.getIdToken() != null);
  //     final User currentUser = _auth.currentUser;
  //     assert(userGoogleLoggedIn.uid == currentUser.uid);
  //
  //     String uid;
  //     List userInfo =
  //         userGoogleLoggedIn.providerData.last.toString().split(', ');
  //     for (String s in userInfo) {
  //       if (s.startsWith('uid: ')) {
  //         uid = s.substring(5, s.length - 1);
  //       }
  //     }
  //     print(uid);
  //
  //     try {
  //       final user1 = await UserAuth().googleRequest(
  //           userGoogleLoggedIn.displayName, userGoogleLoggedIn.email, uid);
  //
  //       if (user1 != null) {
  //         print(user1);
  //         Navigator.pop(context);
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  //   return;
  // }
}
