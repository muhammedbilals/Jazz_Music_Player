import 'package:flutter/material.dart';

class PlayerLogin extends StatelessWidget {
  const PlayerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const HomeMain(),
              //   ),
              // );
            },
            icon: const Icon(Icons.arrow_back)),
      ),
    );
  }
}
// will impliment later