import 'package:flutter/material.dart';



class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),
    ()=> Navigator.pushReplacementNamed(context, '/menu')
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/xo.jpg', width: 200, height: 250,),
      ),
    );
  }
}