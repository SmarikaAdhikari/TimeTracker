// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:timetracker/models/onboard_model.dart';
import 'package:timetracker/screens/loginpage.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  PageController pageController = PageController();
  int currentindex = 0;

  @override
  void initState() {
pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onboard.length,
              onPageChanged: (int index) {
                setState(() {
                  currentindex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
            
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        onboard[index].image,
                        height: 400,
                        width: 500,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        onboard[index].title,textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        
          Container(
            height: 20,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: List.generate(
                  onboard.length, (index) => builderIndicator(index)),
            ),
          ),
             const  SizedBox(
              height: 30,
            ),
          Container(
            height: 50,
            width: 130,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
            
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
                onTap: () {
                  if (currentindex == onboard.length - 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Text(
                  currentindex == onboard.length-1 ? "Next" : "Continue",textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                )),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Container builderIndicator(int index) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: currentindex == index ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
