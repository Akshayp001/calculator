import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String content = "0";
  double answerContent = 0.0;
  List<String> buttonsKeys = [
    'C', 'ANS', '%', 'DEL',
    '1', '2', '3', '+',
    '4', '5', '6', '-',
    '7', '8', '9', 'x',
    '.', '0', '=', '/',
  ];

  Color selectColor(int index) {
    if (index == 19 || index == 7 || index == 11 || index == 15 || index == 2) {
      return Colors.orange.withOpacity(0.6);
    } else if (index == 18 || index == 1) {
      return Colors.blue.withOpacity(0.6);
    } else if (index == 3) {
      return Colors.red.withOpacity(0.6);
    } else if (index == 0) {
      return Colors.green.shade800;
    } else {
      return Colors.grey.shade700;
    }
  }

  void onButtonClick(int index) {
    setState(() {
      // print(content[content.length - 1]);
      // print(index);

      if (isOperator(content[content.length - 1]) &&
          isOperator(buttonsKeys[index])) {
        if (buttonsKeys[index] == content[content.length - 1]) {
          //.
        } else if (isOperator(buttonsKeys[index])) {
          content =
              content.substring(0, content.length - 1) + buttonsKeys[index];
        }
      } else if (index == 0) {
        setState(() {
          content = "0";
          answerContent = 0.0;
        });
      } else if (index == 3) {
        if (content.length == 1) {
          setState(() {
            content = "0";
          });
        } else {
          content = content.substring(0, content.length - 1);
        }
      } else if (index == 1) {
        setState(() {
          content = answerContent.toString();
          answerContent = 0.0;
        });
        //ANS Tapped
      } else if (index == 18) {
        setState(() {
          evaluate();
        });
        //= Tapped
      } else {
        if (content.length == 1 &&
            content == "0" &&
            !isOperator(buttonsKeys[index])) {
          content = buttonsKeys[index];
        } else {
          content += buttonsKeys[index];
        }
      }
    });
  }

  bool isOperator(String temp) {
    if (temp == '+' ||
        temp == '-' ||
        temp == '/' ||
        temp == 'x' ||
        temp == '%') {
      return true;
    } else {
      return false;
    }
  }

  void evaluate() {
    String temp = content;
    if (isOperator(content[content.length - 1])) {
      temp = content.substring(0, content.length - 1);
    }
    if (content.contains('x')) {
      temp = content.replaceAll('x', '*');
    }
    Parser p = Parser();
    Expression exp = p.parse(temp);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answerContent = eval;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Container(
            alignment: Alignment.center,
            // padding: EdgeInsets.all(3),/
            height: 28,
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15),
                color: Colors.black),
            child: Text(
              "CALCULATOR",
              style: TextStyle(fontFamily: 'Teko'),
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AnswerText Container.........
              // AnswerText Container.........
              // AnswerText Container.........
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Answer:",
                      style: TextStyle(
                          fontFamily: 'SourceSerifPro',
                          fontSize: 14,
                          color: Colors.pink),
                    ),
                    Text(
                      "$answerContent",
                      style: TextStyle(
                          fontFamily: 'SourceSerifPro',
                          color: Colors.grey.shade800,
                          fontSize: 30),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    // color: Colors.black,

                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16)),
                height: 80,
                width: MediaQuery.of(context).size.width,
                // width: 360,
                // width: ((MediaQuery.of(context).size.width) > 360)
                //     ? 360
                //     : MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 10,
              ),
              // QuestionText Container.........
              // QuestionText Container.........
              // QuestionText Container.........
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(
                  content,
                  style: TextStyle(
                      fontFamily: 'SourceSerifPro',
                      color: Colors.grey.shade100,
                      fontSize: 30),
                ),
                decoration: BoxDecoration(
                    // color: Colors.black,

                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16)),
                height: 80,
                width: MediaQuery.of(context).size.width,
                // width: 360,
                // width: ((MediaQuery.of(context).size.width) > 360)
                //     ? 360
                //     : MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    // color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(13)),
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                // width: 360,
                // width: ((MediaQuery.of(context).size.width) > 360)
                //     ? 360
                //     : MediaQuery.of(context).size.width,

                child: GridView.builder(
                  // padding: EdgeInsets.all(2),
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        if (index == 3) {
                          setState(() {
                            content = "0";
                            answerContent = 0.0;
                          });
                        }
                      },
                      onTap: () {
                        onButtonClick(index);
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          // index.toString(),
                          buttonsKeys[index],
                          style: TextStyle(
                              // color: ,
                              fontFamily: 'SourceSerifPro',
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        )),
                        decoration: BoxDecoration(
                            color: selectColor(index),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
              )
            ]),
      ),
    );
  }
}
