// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:education_app/src/course/features/exams/data/models/user_choice_model.dart';
import 'package:education_app/src/course/features/exams/data/models/user_exam_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:education_app/src/course/features/exams/domain/entities/question_choice.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_choice.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:flutter/foundation.dart';

/// The `ExamController` class manages the state and logic for handling exams.
///
/// It tracks the progress of an exam, including questions, answers, and timers.
/// The controller keeps track of the current question, remaining time, and user
/// choices. It also handles timer functionality for the exam.
class ExamController extends ChangeNotifier {
  /// Initializes a new `ExamController` with the provided exam.
  ///
  /// The [exam] parameter is required, and it represents the exam to be managed
  /// by the controller.
  ExamController({required Exam exam})
      : _exam = exam,
        _questions = exam.questions! {
    _userExam = UserExamModel(
      examId: exam.id,
      courseId: exam.courseId,
      answers: const [],
      examTitle: exam.title,
      examImageUrl: exam.imageUrl,
      totalQuestions: exam.questions!.length,
      dateSubmitted: DateTime.now(),
    );
    _remainingTime = exam.timeLimit;
  }

  final Exam _exam;

  /// Retrieves the exam associated with this controller.
  Exam get exam => _exam;

  final List<ExamQuestion> _questions;

  /// Retrieves the total number of questions in the exam.
  int get totalQuestions => _questions.length;

  late UserExam _userExam;

  /// Retrieves the user's exam information, including answers and progress.
  UserExam get userExam => _userExam;

  late int _remainingTime;

  /// Checks if the exam's time limit has expired.
  bool get isTimeUp => _remainingTime == 0;

  bool _examStarted = false;

  /// Checks if the exam has started.
  bool get examStarted => _examStarted;

  Timer? _timer;

  /// Retrieves the remaining time in the format 'mm:ss'.
  ///
  /// This getter calculates and returns the remaining time for the exam in the
  /// 'mm:ss' format, where 'mm' represents minutes and 'ss' represents seconds.
  ///
  /// Example:
  /// ```dart
  /// final controller = ExamController(exam: yourExamInstance);
  /// final remainingTime = controller.remainingTime;
  /// print(remainingTime); // Output: '05:30' (5 minutes and 30 seconds remaining)
  /// ```
  String get remainingTime {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Retrieves the remaining time in seconds.
  int get remainingTimeInSeconds => _remainingTime;

  int _currentIndex = 0;

  /// Retrieves the index of the current question.
  int get currentIndex => _currentIndex;

  /// Retrieves the current question.
  ExamQuestion get currentQuestion => _questions[_currentIndex];

  /// Starts the timer for the exam.
  ///
  /// This method initiates the countdown timer for the exam. Once started, it
  /// decrements the remaining time by one second every second until the time
  /// reaches zero. The timer uses the [_remainingTime] variable to keep track
  /// of the time remaining for the exam.
  ///
  /// Example:
  /// ```dart
  /// final controller = ExamController(exam: yourExamInstance);
  /// controller.startTimer(); // Start the timer
  ///
  /// // The timer will update the remaining time and trigger listeners.
  /// controller.addListener(() {
  ///   print('Remaining Time: ${controller.remainingTime}');
  ///   if (controller.isTimeUp) {
  ///     print("Time's up! Exam completed.");
  ///   }
  /// });
  /// ```
  void startTimer() {
    // Mark the exam as started.
    _examStarted = true;

    // Create a periodic timer that updates every second.
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // Check if there's remaining time.
        if (_remainingTime > 0) {
          // Decrement the remaining time by one second.
          _remainingTime--;

          // Notify any listeners that the remaining time has changed.
          notifyListeners();
        } else {
          // If the remaining time reaches zero, cancel the timer.
          timer.cancel();
        }
      },
    );
  }

  /// Stops the timer for the exam.
  ///
  /// This method cancels the countdown timer for the exam, effectively halting
  /// the timer's countdown. It checks if a timer is currently running before
  /// attempting to cancel it. This is useful when you want to manually stop
  /// the timer before it completes naturally.
  ///
  /// Example:
  /// ```dart
  /// final controller = ExamController(exam: yourExamInstance);
  /// controller.startTimer(); // Start the timer
  /// // Some logic...
  /// controller.stopTimer(); // Stop the timer manually
  /// ```
  void stopTimer() {
    // Check if a timer is currently running before attempting to cancel it.
    _timer?.cancel();
  }

  /// Retrieves the user's answer for the current question.
  ///
  /// This getter searches for the user's answer to the current question within
  /// the list of answers submitted by the user during the exam. If a user's
  /// answer is found, it returns the [UserChoice] object representing the
  /// answer. If no answer is found, it returns `null`.
  ///
  /// Example:
  /// ```dart
  /// final controller = ExamController(exam: yourExamInstance);
  /// final userAnswer = controller.userAnswer;
  ///
  /// if (userAnswer != null) {
  ///   print('User\'s Answer: ${userAnswer.userChoice}');
  /// } else {
  ///   print('User has not answered this question.');
  /// }
  /// ```
  ///
  /// Returns the user's answer for the current question or `null` if no answer
  /// is found.
  UserChoice? get userAnswer {
    // Get the list of answers submitted by the user during the exam.
    final answers = _userExam.answers;

    // Initialize a variable to track whether there's no answer.
    var noAnswer = false;

    // Retrieve the ID of the current question.
    final questionId = currentQuestion.id;

    // Search for the user's answer to the current question in the list of answers.
    final userChoice = answers.firstWhere(
      // Check if the question ID matches the ID of the current question.
      (answer) => answer.questionId == questionId,

      // If no matching answer is found, execute the 'orElse' callback.
      orElse: () {
        // Set the 'noAnswer' flag to true to indicate that there's no answer.
        noAnswer = true;

        // Return an empty UserChoiceModel to represent no answer.
        return const UserChoiceModel.empty();
      },
    );

    // If 'noAnswer' is true, return null to indicate no answer;
    // otherwise, return the user's choice.
    return noAnswer ? null : userChoice;
  }

  /// Changes the current index of the exam questions.
  ///
  /// This method allows you to update the current question index within the exam.
  /// It takes an [index] parameter representing the new index to set, and then
  /// notifies any listeners of the change. You can use this method to navigate
  /// between different questions in the exam.
  ///
  /// Example:
  /// ```dart
  /// final controller = ExamController(exam: yourExamInstance);
  /// controller.changeIndex(2); // Change to question at index 2
  /// ```
  void changeIndex(int index) {
    // Update the current question index.
    _currentIndex = index;
    // Notify any listeners about the change.
    notifyListeners();
  }

  /// Moves to the next question in the exam.
  ///
  /// This method allows you to advance to the next question in the exam. It checks
  /// if the exam timer has started and increments the current question index if
  /// there are more questions available. It also notifies any listeners of the
  /// change.
  ///
  /// If the timer has not started, it will be started automatically to track
  /// the remaining time for the exam.
  ///
  /// Example:
  /// ```dart
  /// final controller = ExamController(exam: yourExamInstance);
  /// controller.nextQuestion(); // Move to the next question
  /// ```
  void nextQuestion() {
    // Start the timer if it hasn't already started.
    if (!_examStarted) startTimer();

    // Check if there are more questions available.
    if (_currentIndex < _questions.length - 1) {
      // Increment the current question index.
      _currentIndex++;
      // Notify any listeners about the change.
      notifyListeners();
    }
  }

  /// Moves to the previous question in the exam.
  ///
  /// This method allows you to go back to the previous question in the exam. It
  /// checks if there are previous questions available by verifying the current
  /// question index. If a previous question exists, it decrements the current
  /// question index and notifies any listeners of the change.
  ///
  /// Example:
  /// ```dart
  /// final controller = ExamController(exam: yourExamInstance);
  /// controller.previousQuestion(); // Move to the previous question
  /// ```
  void previousQuestion() {
    // Check if there is a previous question available.
    if (_currentIndex > 0) {
      // Decrement the current question index to move to the previous question.
      _currentIndex--;
      // Notify any listeners about the change.
      notifyListeners();
    }
  }

  /// Records the user's choice for the current question.
  ///
  /// This method allows the user to select a choice as their answer for the
  /// current question in the exam. It checks whether the exam has started, and
  /// if not, it starts the exam timer. It then creates a [UserChoice] instance
  /// representing the user's choice and updates the [_userExam] with this choice.
  /// If the user has previously answered the same question, the method updates
  /// the existing answer; otherwise, it adds a new answer to the list of answers.
  /// Finally, it notifies any listeners of the change.
  ///
  /// Example:
  /// ```dart
  /// final controller = ExamController(exam: yourExamInstance);
  /// final selectedChoice = yourChoice; // Replace with the selected choice
  /// controller.answer(selectedChoice); // Record the user's choice
  /// ```
  void answer(QuestionChoice choice) {
    // Check if the exam has not started and the current index is 0, then start
    // the exam timer.
    if (!_examStarted && currentIndex == 0) startTimer();

    // Create a copy of the current list of user choices.
    final answers = List<UserChoice>.of(_userExam.answers);

    // Create a [UserChoice] instance representing the user's choice.
    final userChoice = UserChoiceModel(
      questionId: choice.questionId,
      correctChoice: currentQuestion.correctAnswer!,
      userChoice: choice.identifier,
    );

    // Check if the user has previously answered the same question.
    if (answers.any((answer) => answer.questionId == userChoice.questionId)) {
      // If so, find the index of the previous answer.
      final index = answers.indexWhere(
        (answer) => answer.questionId == userChoice.questionId,
      );

      // Update the existing answer with the new choice.
      answers[index] = userChoice;
    } else {
      // If not, add the new answer to the list.
      answers.add(userChoice);
    }
    // Update the [_userExam] with the updated list of answers.
    _userExam = (_userExam as UserExamModel).copyWith(answers: answers);

    // Notify any listeners about the change.
    notifyListeners();
  }

  /// Disposes of resources and cancels the exam timer.
  ///
  /// This method should be called when the [ExamController] is no longer needed,
  /// typically in the `dispose` method of the widget that owns the controller.
  /// It cancels the exam timer if it is active to prevent memory leaks and
  /// releases any allocated resources. Make sure to call this method to clean up
  /// the [ExamController] properly.
  @override
  void dispose() {
    // Cancel the exam timer if it is active.
    _timer?.cancel();
    super.dispose();
  }
}
