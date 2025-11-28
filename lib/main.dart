import 'package:cashwise/pages/addexpensescreen.dart';
import 'package:cashwise/pages/transactionhistory.dart';
import 'package:flutter/material.dart';
import 'pages/loadingscreen.dart';
import 'pages/summaryscreen.dart';
import 'pages/addincomescreen.dart';
import 'pages/transactionhistory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF02032D),   
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0XFF56DFB1),
        ),
      ),
      home: const LoadingScreen(),
      routes: {
        '/summary': (context) => const SummaryScreen(),
        '/onboarding' : (context) => const LoadingScreen(),
        '/addincome': (context) => const AddIncomeScreen(),
        '/addexpenses': (context) => const AddExpenseScreen(),
        '/history' : (context) => const TransactionHistory(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}