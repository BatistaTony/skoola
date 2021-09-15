import 'package:flutter/material.dart';
import 'package:skoola/components/customButton.dart';
import 'package:skoola/components/simpleAppBar.dart';
import 'package:skoola/models/tests.dart';

class CourseTest extends StatefulWidget {
  const CourseTest({Key? key}) : super(key: key);

  @override
  _CourseTestState createState() => _CourseTestState();
}

class _CourseTestState extends State<CourseTest> {
  int questionsNumber = 20;
  int _questionAnsweredNumber = 1;
  bool isQuestionAnswered = true;
  final _formsPageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: SimpleAppBar(title: "Components").build(context),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "$_questionAnsweredNumber of $questionsNumber Questions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffF9F7F3),
                  fontFamily: 'Rubik',
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 95),
              height: size.height * 0.63,
              child: PageView.builder(
                  allowImplicitScrolling: true,
                  controller: _formsPageViewController,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return TestQuestion(
                      checkAnswer: checkAnswer,
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ButtonApp(
                  isDisabled: isQuestionAnswered,
                  press: !isQuestionAnswered ? nextQuestion : null,
                  title: "Next",
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void checkAnswer(value) {
    setState(() {
      isQuestionAnswered = !value;
    });
  }

  void nextQuestion() {
    _formsPageViewController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInCubic,
    );

    setState(() {
      _questionAnsweredNumber = _questionAnsweredNumber + 1;
      isQuestionAnswered = true;
    });

    if (questionsNumber == _questionAnsweredNumber) {
      //check the rights and wrongs answers
      Navigator.pushNamed(context, "failedTest");
    }
  }
}

class TestQuestion extends StatefulWidget {
  final Function(bool? value)? checkAnswer;
  const TestQuestion({Key? key, this.checkAnswer}) : super(key: key);

  @override
  _TestQuestionState createState() => _TestQuestionState();
}

class _TestQuestionState extends State<TestQuestion> {
  int answerId = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                child: Text(
                  "What a Components look like  ? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Rubik-Medium',
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: answers
                  .map((answer) => CourseAnswer(
                        answer: answer.text,
                        isRight: answer.isRight,
                        isCliked: answer.id == answerId,
                        press: () => choose(answer.id),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void choose(int? id) {
    setState(() {
      if (answerId == id) {
        answerId = 0;
      } else {
        answerId = id!;
      }
    });

    widget.checkAnswer!(answerId != 0);
  }
}

class CourseAnswer extends StatefulWidget {
  final VoidCallback? press;
  final String? answer;
  final bool? isRight;
  final bool? isCliked;
  const CourseAnswer(
      {Key? key,
      this.press,
      this.answer,
      this.isRight = false,
      this.isCliked = false})
      : super(key: key);

  @override
  _CourseAnswerState createState() => _CourseAnswerState();
}

class _CourseAnswerState extends State<CourseAnswer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 17),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              widget.isCliked ?? false ? Color(0xff38336C) : Color(0xff3F3D56),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width * 0.72,
              child: Text(
                widget.answer!,
                style: TextStyle(
                  color: Color(0xffBCF4F4),
                  fontFamily: 'Rubik',
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: widget.isCliked ?? false
                      ? Color(0xff0079F1)
                      : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100)),
            )
          ],
        ),
      ),
    );
  }

  dynamic checkAnswer() {
    if (widget.isCliked! && widget.isRight!) {
      return {"bg": Color(0xff00A9B6), "border": Color(0xff0079F1)};
    } else if (widget.isCliked!) {
      return {"bg": Color(0xff38336C), "border": Colors.transparent};
    }
  }

  void press() {
    widget.press!();
  }
}
