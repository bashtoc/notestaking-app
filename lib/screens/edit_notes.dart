
import 'package:flutter/material.dart';
import '../models/user_management.dart';
import 'constants.dart';
import 'homepage.dart';

class EditField extends StatefulWidget {
  const EditField({Key? key, this.id, this.title, this.story})
      : super(key: key);

  final String? title;
  final String? story;
  final String? id;

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController story = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      title.text = widget.title!;
      story.text = widget.story!;
    });
  }

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
          'Edit notes',
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
                      controller: title,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: ('Enter title here'),
                      ),
                      style: const TextStyle(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' field required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    TextFormField(
                      maxLines: 8,
                      controller: story,
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

                        DbHelper()
                            .update(
                                id: widget.id,
                                title: title.text.trim(),
                                story: story.text.trim())
                            .catchError((e) {
                          print(e);
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const HomePage()));
                        // something happens when its pressed

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
