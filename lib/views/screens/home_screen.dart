import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guess_the_word/controllers/word_controller.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final wordController = Get.put(WordController());

  int currentUserAnswer = 0;

  List<String> gifs = [
    'boy',
    'boys',
    'dance',
    'dancing',
    'man',
    'minions',
    'office',
    'sheep',
    'yes'
  ];

  List<String> userAnswer = [];
  List<String> answers = [];

  @override
  void initState() {
    super.initState();
    answers = wordController.answers;

    userAnswer = List.generate(
      wordController.question['answer'].length,
      (index) {
        return '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/nature.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            top: MediaQuery.of(context).viewPadding.top + 20,
            right: 20,
            bottom: 80,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(
                            color: Colors.red,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          wordController.inCorrectAnswers.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        "Incorrect",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (wordController.currentQuestion.value + 1).toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        "Question",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(
                            color: Colors.green,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          wordController.correctAnswers.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        "Correct",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Expanded(
                child: Center(
                  child: Obx(
                    () {
                      return Text(
                        wordController.question['question'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(
                                  2.0, 2.0), // Position of the shadow (x, y)
                              blurRadius: 3.0, // Blur radius of the shadow
                              color: Color.fromARGB(128, 0, 0,
                                  0), // Color of the shadow with transparency
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  userAnswer.length,
                  (index) {
                    return SizedBox(
                      width: 55,
                      height: 55,
                      child: Container(
                        decoration: BoxDecoration(
                          color: userAnswer[index] != ''
                              ? Colors.lightGreen
                              : Colors.white,
                          border: Border.all(
                              width: 3,
                              color: userAnswer[index] != ''
                                  ? Colors.lightGreen
                                  : Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            userAnswer[index].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: answers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          userAnswer[currentUserAnswer] = answers[index];
                          answers[index] = '';

                          if (userAnswer.join('') ==
                                  wordController.question['answer'].join('') &&
                              !userAnswer.contains('')) {
                            wordController.incrementCorrect();
                            Get.defaultDialog(
                              barrierDismissible: false,
                              title: "Correct 👍",
                              content: Image.asset(
                                  "assets/gifs/${gifs[Random().nextInt(8)]}.gif"),
                            );
                            wordController.nextQuestion();
                            if (wordController.currentQuestion.value == 0) {
                              Future.delayed(const Duration(seconds: 4), () {
                                Lottie.asset('assets/congrats.json');
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: "Your statistics",
                                  content: Column(
                                    children: [
                                      Text(
                                          "Correct answer: ${wordController.correctAnswers}"),
                                      Text(
                                          "Incorrect answer: ${wordController.inCorrectAnswers}")
                                    ],
                                  ),
                                  cancel: TextButton(
                                      onPressed: () {
                                        SystemNavigator.pop();
                                      },
                                      child: const Text("Exit")),
                                  confirm: FilledButton(
                                    onPressed: () {
                                      wordController.reset();
                                      Get.back();
                                    },
                                    child: const Text("Again"),
                                  ),
                                );
                              });
                            }
                            answers = wordController.answers;
                            userAnswer = List.generate(
                              wordController.question['answer'].length,
                              (index) {
                                return '';
                              },
                            );
                            Future.delayed(const Duration(seconds: 3), () {
                              Get.back();
                            });
                            currentUserAnswer = -1;
                          } else if (!userAnswer.contains('') &&
                              userAnswer.join('') !=
                                  wordController.question['answer'].join('')) {
                            Get.defaultDialog(
                              barrierDismissible: false,
                              title: "Incorrect 👎",
                              content: Image.asset("assets/gifs/no.gif"),
                            );
                            wordController.nextQuestion();
                            if (wordController.currentQuestion.value == 0) {
                              Future.delayed(const Duration(seconds: 4), () {
                                Lottie.asset('assets/congrats.json');
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: "Your statistics",
                                  content: Column(
                                    children: [
                                      Text(
                                          "Correct answer: ${wordController.correctAnswers}"),
                                      Text(
                                          "Incorrect answer: ${wordController.inCorrectAnswers}")
                                    ],
                                  ),
                                  cancel: TextButton(
                                      onPressed: () {
                                        SystemNavigator.pop();
                                      },
                                      child: const Text("Exit")),
                                  confirm: FilledButton(
                                    onPressed: () {
                                      wordController.reset();
                                      Get.back();
                                    },
                                    child: const Text("Again"),
                                  ),
                                );
                              });
                            }
                            wordController.incrementInCorrect();
                            answers = wordController.answers;
                            userAnswer = List.generate(
                              wordController.question['answer'].length,
                              (index) {
                                return '';
                              },
                            );
                            Future.delayed(const Duration(seconds: 3), () {
                              Get.back();
                            });
                            currentUserAnswer = -1;
                          }

                          if (currentUserAnswer < userAnswer.length - 1) {
                            currentUserAnswer++;
                          } else {
                            currentUserAnswer = 0;
                          }
                        });
                      },
                      child: answers[index] == ''
                          ? const SizedBox()
                          : SizedBox(
                              width: 55,
                              height: 55,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    answers[index].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
