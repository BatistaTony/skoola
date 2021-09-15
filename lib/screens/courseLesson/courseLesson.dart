import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark-reasonable.dart';
import 'package:skoola/components/simpleAppBar.dart';

class CourseLesson extends StatelessWidget {
  const CourseLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var code = ''' 
    import { startTransition } from 'react';

    setInputValue(input);

    // Mark any state updates inside as transitions
    startTransition(() => {
      // Transition: Show the results
      setSearchQuery(input);
    });
          ''';
    var text =
        "You can launch a new career in web develop-ment today by learning HTML & CSS. You don't need a computer science degree or expensive software. All you need is a computer, a bit of time, a lot of determination, and a teacher you trust.";
    return Scaffold(
      appBar:
          SimpleAppBar(title: "Deep Introduction on Reactjs").build(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              children: [
                buildTitle("React Components"),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: RichText(
                    locale: Locale("en", "US"),
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontSize: 17,
                        ),
                        children: [
                          TextSpan(
                              text: text[0], style: TextStyle(fontSize: 30)),
                          TextSpan(text: text),
                          TextSpan(text: text),
                        ]),
                  ),
                ),
                SourceCode(
                  code: code,
                  language: "javascript",
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: RichText(
                    locale: Locale("en", "US"),
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontSize: 17,
                        ),
                        children: [
                          TextSpan(text: text),
                          TextSpan(text: text),
                        ]),
                  ),
                ),
                buildTitle("React Context Api"),
                SourceCode(
                  code: code,
                  language: "javascript",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 5),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Rubik-Medium',
          fontSize: 18,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class SourceCode extends StatelessWidget {
  final String? code;
  final String? language;
  const SourceCode({Key? key, this.language, this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        child: Column(
      children: [
        Container(
          width: size.width,
          margin: EdgeInsets.only(top: 5),
          height: 6,
          decoration: BoxDecoration(
              color: Color(0xff282c37),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10))),
        ),
        Container(
          width: size.width,
          margin: EdgeInsets.only(bottom: 25),
          child: Column(
            children: [
              Container(
                width: size.width,
                padding: EdgeInsets.only(left: 10, bottom: 5),
                decoration: new BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Color(0xff3F3D56),
                  )),
                  color: Color(0xff282c37),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Color(0xffDB3C3C),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: 7,
                      height: 7,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: Color(0xff0079F1),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Color(0xff1BAD70),
                          borderRadius: BorderRadius.circular(100)),
                    )
                  ],
                ),
              ),
              Container(
                width: size.width,
                child: HighlightView(
                  code!,
                  theme: atomOneDarkReasonableTheme,
                  language: language,
                  textStyle: TextStyle(
                    fontFamily: 'Rubik-Medium',
                    fontSize: 11,
                  ),
                  padding: EdgeInsets.only(left: 10, top: 10),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
