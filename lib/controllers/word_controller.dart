import 'dart:math';

import 'package:get/get.dart';

class WordController extends GetxController {
  RxInt inCorrectAnswers = 0.obs;
  RxInt correctAnswers = 0.obs;

  RxInt currentQuestion = 0.obs;

  List<Map<String, dynamic>> questions = [
    {
      'question': "Bozordan bir oldim. Uyga ming keldim.",
      'answer': ['a', 'n', 'o', 'r']
    },
    {
      'question': "Yerdagi to'q sariq tirnoq.",
      'answer': ['s', 'a', 'b', 'z', 'i']
    }
  ];

  Map<String, dynamic> get question {
    return questions[currentQuestion.value];
  }

  List<String> get answers {
    const String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    List<String> randomLetters = [];

    for (int i = 0;
        i < 10 - questions[currentQuestion.value]['answer'].length;
        i++) {
      int randomIndex = random.nextInt(alphabet.length);
      randomLetters.add(alphabet[randomIndex]);
    }
    List<String> combinedList = [
      ...randomLetters,
      ...questions[currentQuestion.value]['answer']
    ];

    combinedList.shuffle();

    return combinedList;
  }

  void incrementInCorrect() {
    inCorrectAnswers++;
  }

  void incrementCorrect() {
    correctAnswers++;
  }

  void nextQuestion() {
    currentQuestion++;
  }
}
