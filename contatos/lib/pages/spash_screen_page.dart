import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:contatos/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  openHome() {
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    openHome();
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.green, Colors.black],
              stops: [0.2, 0.5, 0.7])),
      child: Center(
          child: SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText('Bem Vindo'),
              FadeAnimatedText('ao app Contatos'),
              FadeAnimatedText('by DC7'),
            ],
          ),
        ),
      )),
    ));
  }
}
