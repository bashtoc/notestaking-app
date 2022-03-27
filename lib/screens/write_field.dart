import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_management.dart';
import 'constants.dart';

class WriteField extends StatefulWidget {
  const WriteField({Key? key}) : super(key: key);

  @override
  State<WriteField> createState() => _WriteFieldState();
}

class _WriteFieldState extends State<WriteField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String title = '';
  String story = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Start writing',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),


                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      onChanged: (value) {
                        title = value;
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: ('Enter title here'),
                      ),
                      style: const TextStyle(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' field required';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    TextFormField(
                      maxLines: 8,
                      onChanged: (value) {
                        story = value;
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: ('Enter text here'),
                      ),
                      style: const TextStyle(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' field required';
                        }
                        return null;
                      },
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final firebaseUser = FirebaseAuth.instance.currentUser;
                      if (firebaseUser != null) {
                        DbHelper().add(title: title, story: story);

                        Navigator.pop(context);
                        // something happens when its pressed
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
                      'finish',
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
      ),
    );
  }
}
