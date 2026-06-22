
import 'package:flutter/material.dart';

class OnboardingForm extends StatelessWidget {
  final String title;
  final String description;
  final int index;

  const OnboardingForm({
    super.key,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 375,
            child: ClipRect(
              child: Image.asset(
                "assets/images/onboarding/illustration-full.png",
                  width: MediaQuery.of(context).size.width * 3,
                  fit: BoxFit.none,
                  alignment: index == 0 ? Alignment.centerLeft : index == 1 ? Alignment.center : Alignment.centerRight,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == index ? Colors.green : const Color.fromARGB(255, 240, 240, 240),
            ),
          )),
        ),
        const SizedBox(height: 30,),

        Text(
          title,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF Pro Display',
            color: Color.fromARGB(255, 21, 150, 25),
          ),
        ),

        const SizedBox(height: 15,),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'ABeeZee',
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        )
      ]
    );
  }
}