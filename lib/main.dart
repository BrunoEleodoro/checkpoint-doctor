import 'package:checkpoint_doctor/pages/criar_carteira.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckPoint - Doctor',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: GoogleFonts.reemKufi().fontFamily),
      debugShowCheckedModeBanner: false,
      home: CriarCarteiraPage(),
    );
  }
}
