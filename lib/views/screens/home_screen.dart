import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guess_the_word/controllers/word_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final wordController = Get.put(WordController());

  int currentUserAnswer = 0;

  List<String> userAnswer = [];

  @override
  void initState() {
    super.initState();

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
                        child: const Text(
                          "0",
                          style: TextStyle(
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
                        child: const Text(
                          "1",
                          style: TextStyle(
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
                        child: const Text(
                          "1",
                          style: TextStyle(
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
                          color: Colors.white,
                          border: Border.all(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            userAnswer[index].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                  itemCount: wordController.answers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          userAnswer[currentUserAnswer] =
                              wordController.answers[index];

                          try {
                            currentUserAnswer++;
                          } catch (e) {
                            currentUserAnswer = 0;
                          }
                        });
                      },
                      child: SizedBox(
                        width: 55,
                        height: 55,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              wordController.answers[index].toUpperCase(),
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
