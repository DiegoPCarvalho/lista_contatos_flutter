import 'package:contatos/pages/spash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContatosMain extends StatefulWidget {
  const ContatosMain({super.key});

  @override
  State<ContatosMain> createState() => _ContatosMainState();
}

class _ContatosMainState extends State<ContatosMain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 20, 126, 16)),
            useMaterial3: true,
            textTheme: GoogleFonts.robotoMonoTextTheme()),
        home: const SplashScreenPage());
  }
}
