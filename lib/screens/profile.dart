import 'package:bioself/screens/constants.dart';
import 'package:bioself/screens/reset_password.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap:(){
          Navigator.pop(context);
        },child: const Icon( Icons.arrow_back_ios,color: Colors.black,)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile', style: TextStyle(color: Colors.black),
        ),
      ),
    body: Column(
      children: [
        const SizedBox(height: 20,),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Password', style: TextStyle(fontSize: 18),),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('**********'),
          height: 100,
          width: 365,
          color: const Color(0xffF2F2F2),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              TextButton(onPressed: () { Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const ResetPassword())); },
              child: const Text('Reset', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: buttonColor),)),
            ],
          ),
        )

      ],
    ),
    );
  }
}
