import 'package:bioself/screens/login.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String? validatePass(value) {
    {
      if (value!.isEmpty) {
        return 'Field required';
      } else {
        return null;
      }
    }
  }

  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body:  BlurryModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Column(children: [
            const Text(
              'Reset Password',
              style: TextStyle(
                  color: buttonColor, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: validatePass,
                textAlign: TextAlign.center,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: ktextfield.copyWith(
                    hintText: 'Enter your email', labelText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () async {

                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                 }
                try{
                await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LogIn()));
                }on FirebaseAuthException catch (error) {
                  fToast.showToast(
                    toastDuration: const Duration(seconds: 4),

                    child: Material(

                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          const Icon(Icons.face),
                          Text(
                            error.message.toString(),
                            style: const TextStyle(color: Colors.black87, fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    gravity: ToastGravity.TOP,
                  );
                  setState(() {
                    isLoading = false;
                  });
                }

              },
              child: Container(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                alignment: Alignment.center,
                height: 53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: buttonColor,
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ]),
        )),
      ),
    );
  }
}
