import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:phone_verification/screens/home_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Image.asset('assets/otp.JPG'),
        SizedBox(height: 20),
        Text(
          'ENTER YOUR NUMER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: Color.fromARGB(255, 70, 0, 150))),
            hintText: "Mobile Number",
          ),
        ),

        SizedBox(
          height: 16,
        ),
        // ignore: deprecated_member_use
        ElevatedButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                //signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                // ignore: deprecated_member_use
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text(verificationFailed.message)));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Text("PROCEED"),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 114, 76, 175),
            onPrimary: Colors.white,
            shadowColor: Color.fromARGB(255, 168, 105, 240),
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
            minimumSize: Size(400, 40), //////// HERE
          ),
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        Image.asset('assets/enter_otp.JPG'),
        TextField(
          controller: otpController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter OTP manually",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text("VERIFY"),
          color: Color.fromARGB(255, 166, 33, 243),
          textColor: Colors.white,
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Didn't recieve otp?",
                style: TextStyle(color: Colors.grey)),
            TextSpan(
                text: " Resend",
                style: TextStyle(
                    color: Color.fromARGB(255, 159, 33, 243),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    setState(() {
                      showLoading = true;
                    });

                    await _auth.verifyPhoneNumber(
                      phoneNumber: phoneController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                        //signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(verificationFailed.message)));
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          currentState =
                              MobileVerificationState.SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                  })
          ]),
        ),
        SizedBox(height: 30),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: phoneController.text,
                style: TextStyle(color: Color.fromARGB(255, 12, 12, 12))),
            TextSpan(
                text: " Change?",
                style: TextStyle(
                    color: Color.fromARGB(255, 159, 33, 243),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  })
          ]),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Sending OTP to the above number",
          style: TextStyle(
              color: Color.fromARGB(255, 105, 100, 100).withOpacity(0.6)),
        ),

        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}
