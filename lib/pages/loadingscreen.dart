import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: onboardingScreen2(),
    );
  }
}

class onboardingScreen1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/logo.png'), 
              height: 230,
              width: 230,
              fit: BoxFit.cover,
            ),
            const Text('CASHWISE', style: TextStyle(
              fontFamily: 'BebasNeue',
              fontWeight: FontWeight.bold,
              fontSize: 68,
              color: Color(0XFF02032D)
            )), 
            const SizedBox(height: 10),
            const Text('Track Smarter, Spend Wiser', style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0XFF02032D)
            ),),
          ],
        )
      )
    );
  }
}

class onboardingScreen2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
            Padding(padding: EdgeInsets.all(30),
            child: const Text('Easily manage your expenses and stay in control of your budget.', style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              color: Color(0XFF02032D),
              fontSize: 26,
            ),textAlign: TextAlign.left,),),
            Image(image: AssetImage('assets/images/loadingvector.png'), 
              height: 350,
              width: 350,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50,),
            ElevatedButton(onPressed: () => {}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF02032D),
                  foregroundColor: Color(0XFF56DFB1),
                  minimumSize: Size(296, 58),
                ), 
                child: const Text('Get Started', style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),),  
              )
           ],
        ),
      ),
    );
  }
}