import 'package:flutter/material.dart';
import 'package:lista_contatos/pages/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSize(
          duration: Duration(milliseconds: 800),
          child: SizedBox(
            width: 120,
            height: 120,
            child: Image.asset('assets/icon/icon.png', width: 25, height: 25),
          ),
        ),
      ),
    );
  }
}
