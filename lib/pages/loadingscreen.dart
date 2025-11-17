import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final LiquidController _controller = LiquidController();
  int _currentPage = 0;

  final pages = [
    OnboardingScreen1(),
    OnboardingScreenB(),
    OnboardingScreen2(),
  ];

  final List<Color> indicatorColor = [
    Color(0xFF02032D),
    Color(0XFF56DFB1),
    Color(0xFF02032D)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            enableLoop: false,
            fullTransitionValue: 600,
            waveType: WaveType.liquidReveal,
            enableSideReveal: false,
            liquidController: _controller,
            onPageChangeCallback: (index) {
              setState(() => _currentPage = index);
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentPage == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? indicatorColor[_currentPage]
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 230,
              width: 230,
              fit: BoxFit.cover,
            ),
            const Text(
              'CASHWISE',
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontWeight: FontWeight.bold,
                fontSize: 68,
                color: Color(0XFF02032D),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Track Smarter, Spend Wiser',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0XFF02032D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreenB extends StatelessWidget {
  const OnboardingScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFF02032D), 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Easily manage your expenses and stay in control of your budget.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF56DFB1),
                  fontSize: 26,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Image.asset(
              'assets/images/onBoardingb.png',
              height: 310,
              width: 310,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 116, 246, 202), // Page 2 background
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Easily manage your expenses and stay in control of your budget.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF02032D),
                  fontSize: 26,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Image.asset(
              'assets/images/loadingvector.png',
              height: 350,
              width: 350,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/summary');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF02032D),
                foregroundColor: const Color(0XFF56DFB1),
                minimumSize: const Size(296, 58),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

