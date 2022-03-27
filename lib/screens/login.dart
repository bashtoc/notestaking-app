import 'package:bioself/screens/homepage.dart';
import 'package:bioself/screens/reset_password.dart';
import 'package:bioself/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LogIn extends StatefulWidget {
  LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

//Initialize and update counter if available
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            child: Column(
              children: [
                const SizedBox(
                  height: 80.0,
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: ktextfield.copyWith(
                              hintText: 'Enter your email',
                              labelText: ' Email'),
                          onChanged: (value) {
                            email = value.toString();
                          },
                          validator: validatePass,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: ktextfield.copyWith(
                              hintText: 'Enter your password',
                              labelText: 'Password'),
                          validator: validatePass,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextButton(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPassword()));
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: buttonColor),
                            ),
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                final newUser = await _auth
                                    .signInWithEmailAndPassword(
                                        email: email, password: password)
                                    .then((user) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage())));
                                if (newUser != null) {}
                                setState(() {
                                  isLoading = false;
                                });
                              } on FirebaseAuthException catch (error) {
                                fToast.showToast(
                                  toastDuration: const Duration(seconds: 4),
                                  child: Material(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.face),
                                        Text(
                                          error.message.toString(),
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16.0),
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
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));

                      //do something when pressed.
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
