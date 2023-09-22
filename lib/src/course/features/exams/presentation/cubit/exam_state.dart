part of 'exam_cubit.dart';

/// Represents different states related to exams.
///
/// Extends [Equatable] for equality comparison.
sealed class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of exam-related operations.
final class ExamInitial extends ExamState {
  const ExamInitial();
}

/// Represents the state when exams are being fetched.
final class GettingExams extends ExamState {
  const GettingExams();
}

/// Represents the state when user exams are being fetched.
final class GettingUserExams extends ExamState {
  const GettingUserExams();
}

/// Represents the state when exam questions are being fetched.
final class GettingExamQuestions extends ExamState {
  const GettingExamQuestions();
}

/// Represents the state when an exam is being submitted.
final class SubmittingExam extends ExamState {
  const SubmittingExam();
}

/// Represents the state when an exam is being uploaded.
final class UploadingExam extends ExamState {
  const UploadingExam();
}

/// Represents the state when an exam is being updated.
final class UpdatingExam extends ExamState {
  const UpdatingExam();
}

/// Represents the state when exams have been successfully loaded.
final class ExamsLoaded extends ExamState {
  const ExamsLoaded(this.exams);

  final List<Exam> exams;

  @override
  List<Object> get props => [exams];
}

/// Represents the state when user course exams have been successfully loaded.
final class UserCourseExamsLoaded extends ExamState {
  const UserCourseExamsLoaded(this.exams);

  final List<UserExam> exams;

  @override
  List<Object> get props => [exams];
}

/// Represents the state when user exams have been successfully loaded.
final class UserExamsLoaded extends ExamState {
  const UserExamsLoaded(this.exams);

  final List<UserExam> exams;

  @override
  List<Object> get props => [exams];
}

/// Represents the state when exam questions have been successfully loaded.
final class ExamQuestionsLoaded extends ExamState {
  const ExamQuestionsLoaded(this.questions);

  final List<ExamQuestion> questions;

  @override
  List<Object> get props => [questions];
}

/// Represents the state when an exam has been successfully submitted.
final class ExamSubmitted extends ExamState {
  const ExamSubmitted();
}

/// Represents the state when an exam has been successfully uploaded.
final class ExamUploaded extends ExamState {
  const ExamUploaded();
}

/// Represents the state when an exam has been successfully updated.
final class ExamUpdated extends ExamState {
  const ExamUpdated();
}

/// Represents the error state with an associated error message.
final class ExamError extends ExamState {
  const ExamError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
