part of 'exam_cubit.dart';

sealed class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

final class ExamInitial extends ExamState {
  const ExamInitial();
}

final class GettingExams extends ExamState {
  const GettingExams();
}

final class GettingUserExams extends ExamState {
  const GettingUserExams();
}

final class GettingExamQuestions extends ExamState {
  const GettingExamQuestions();
}

final class SubmittingExam extends ExamState {
  const SubmittingExam();
}

final class UploadingExam extends ExamState {
  const UploadingExam();
}

final class UpdatingExam extends ExamState {
  const UpdatingExam();
}

final class ExamsLoaded extends ExamState {
  const ExamsLoaded(this.exams);

  final List<Exam> exams;

  @override
  List<Object> get props => [exams];
}

final class UserCourseExamsLoaded extends ExamState {
  const UserCourseExamsLoaded(this.exams);

  final List<UserExam> exams;

  @override
  List<Object> get props => [exams];
}

final class UserExamsLoaded extends ExamState {
  const UserExamsLoaded(this.exams);

  final List<UserExam> exams;

  @override
  List<Object> get props => [exams];
}

final class ExamQuestionsLoaded extends ExamState {
  const ExamQuestionsLoaded(this.questions);

  final List<ExamQuestion> questions;

  @override
  List<Object> get props => [questions];
}

final class ExamSubmitted extends ExamState {
  const ExamSubmitted();
}

final class ExamUploaded extends ExamState {
  const ExamUploaded();
}

final class ExamUpdated extends ExamState {
  const ExamUpdated();
}

final class ExamError extends ExamState {
  const ExamError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
