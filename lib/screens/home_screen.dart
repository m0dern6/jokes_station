import 'package:flutter/material.dart';
import 'package:jokes_station/themes/colors.dart';
import 'package:jokes_station/widgets/jokes_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Jokes Station'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          const JokesCard(),
        ],
      ),
    );
  }
}
