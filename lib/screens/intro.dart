
import 'package:bioself/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              image: SvgPicture.asset('assets/Storyboard-amico.svg',height: 250, width: 250,),
              title:
                  'Tell your story yourself, your '
                      'stories are best told by you,',
              body: (''),
            ),
            PageViewModel(
              image: SvgPicture.asset('assets/o.svg',height: 220, width: 220,),
              title: 'Make every moment count, write about them,'
                  ' create memories in writing.',
              body: (''),
            ),
            PageViewModel(
              image: SvgPicture.asset('assets/writee.svg',height: 250, width: 250,),
              title: 'Detail each moment with pictures, memories are'
                  ' beautiful with pictures...',
              body: (''),
              footer: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color(0xff417549),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
          done: const Text(''),
          onDone: () {},
          showSkipButton: true,
          skip: const Text('skip'),
          showNextButton: true,
          next: const Icon(Icons.arrow_forward),
          dotsDecorator: getDotsDecorator(),
        ),
      ),
    );
  }
}

DotsDecorator getDotsDecorator() => DotsDecorator(
    size: const Size(10, 10),
    activeSize: const Size(22, 10),
    activeColor: const Color(0xff417549),
    activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
