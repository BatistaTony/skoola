class CourseEntity {
  String? id;
  String? name;
  String? tutor;
  int? totalTime;
  String? category;
  String? cover;
  String? description;
  double? price;
  List<TagsEntity>? tags;
  List<CourseTopicEntity>? topics;
  List<CourseItemContentEntity>? items;
  DateTime? publishedAt;
}

class UserEntity {
  String? id;
  String? name;
  String? country;
  String? avatar;
  String? email;

  UserEntity(this.id, this.avatar, this.country, this.email, this.name);
}

class SavedCourseEntity {
  List<CourseEntity>? coursesSaved;
}

class UserProgressEntity {
  String? id;
  String? userId;
  String? courseId;
  DateTime? startAt; //data of the beginning
  DateTime? dueTime; //data to finish the course
  int? progressNumber;
  bool? isCompleted;
}

class TagsEntity {
  int? id;
  String? title;
}

class CourseTopicEntity {
  String? title;
  String? contentId;
}

class CourseItemContentEntity {
  String? id;
  String? description;
  bool? isCompleted;
  String? content;
  bool? hasCode;
  ItemQuizEntity? quiz;
}

class ItemQuizEntity {
  String? id;
  int? numberOfQuestions;
  int? totalScore;
  List<QuestionEntity>? questions;
}

class QuestionEntity {
  int? id;
  String? title;
  List<String>? possibleAnswer;
  int? rightQuestionId;
  int? questionScore;
}

class ErrorType {
  bool status = false;
  String msg = "";
  String field = "";

  ErrorType(this.status, this.field, this.msg);
}
