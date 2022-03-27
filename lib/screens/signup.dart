
import 'package:bioself/screens/homepage.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validatePass(value) {
    {
      if (value!.isEmpty) {
        return 'field required';
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

  final _auth = FirebaseAuth.instance;

  String email = '';

  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Sign up',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlurryModalProgressHUD(
        inAsyncCall: isLoading,
        blurEffectIntensity: 2,
        dismissible: false,
        progressIndicator: const CircularProgressIndicator(
          color: buttonColor,
        ),
        opacity: 0.4,
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          textAlign: TextAlign.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: validatePass,
                          decoration: ktextfield.copyWith(
                              hintText: 'Enter your email', labelText: 'Email'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            password = value;
                          },
                          textAlign: TextAlign.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: validatePass,
                          decoration: ktextfield.copyWith(
                            hintText: 'Select Password',
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: const [
                            Text('By signing up, you agree to our '),
                          ],
                        ),

                        RichText(
                          text:const TextSpan(

                            style: TextStyle(color: Colors.green),)),
                              TextButton(
                                  onPressed: (){launch('https://www.termsandconditionsgenerator.com/live.php?token=M4SXz9BCTAyxCorKfclKuzxNfmAclPIz');},
                                  child: const Text(
                                    'Terms and conditions',

                        ),),

                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()));
                              } on FirebaseAuthException catch (error) {
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
                              'Sign up',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogIn(),
                                  ),
                                );

                                //do something when pressed.
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
