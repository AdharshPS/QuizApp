import 'package:first_app/utils/color_constant/color_constant.dart';
import 'package:first_app/utils/database/database.dart';
import 'package:first_app/view/result_screen/result_screen.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String next = "next";
  void nextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(total: total),
      ),
    );
  }

  void counter() {
    setState(() {});
    checkValue = null;
    pageNumber == Database.qa.length - 2 ? next = "finish" : next = "next";
    isPressed == true
        ? pageNumber == Database.qa.length - 1
            ? nextButton()
            : pageNumber = pageNumber + 1
        : showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("alert dialog"),
              content: Text("enter any option"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("ok"),
                ),
              ],
            ),
          );
    isPressed = false;
  }

  bool isPressed = false;
  int total = 0;
  int? checkValue;
  int pageNumber = 0;
  Color? color = colorConstant.containerColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: colorConstant.containerColor,
                      ),
                      child: Center(
                        child: Text(
                          Database.qa[pageNumber]["question"],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: colorConstant.TextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colorConstant.buttonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${pageNumber + 1}/${Database.qa.length}",
                        style: TextStyle(
                          color: colorConstant.TextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        isPressed == true
                            ? checkValue == index
                                ? checkValue ==
                                        Database.qa[pageNumber]["answer"]
                                    ? colorConstant.rightColor
                                    : colorConstant.wrongColor
                                : colorConstant.containerColor
                            : colorConstant.containerColor,
                      ),
                    ),
                    onPressed: () {
                      isPressed = true;
                      checkValue = index + 1;
                      setState(() {});
                      checkValue == index + 1
                          ? checkValue == Database.qa[pageNumber]["answer"]
                              ? total++
                              : total = total
                          : total = total;
                    },
                    child: Text(
                      Database.qa[pageNumber]["options"][index],
                      style: TextStyle(
                          color: colorConstant.TextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(colorConstant.buttonColor),
                      foregroundColor:
                          MaterialStatePropertyAll(colorConstant.TextColor)),
                  onPressed: () {
                    counter();
                  },
                  child: Text(next),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(colorConstant.buttonColor),
                        foregroundColor:
                            MaterialStatePropertyAll(colorConstant.TextColor)),
                    onPressed: () {
                      pageNumber = 0;
                      total = 0;
                      isPressed = false;
                      setState(() {});
                      // pageNumber == 0
                      //     ? pageNumber = 0
                      //     : pageNumber = pageNumber - 1;
                      // total--;
                    },
                    child: Text("Restart"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
