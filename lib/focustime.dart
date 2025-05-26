import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Focustime extends StatefulWidget {
  const Focustime({super.key});

  @override
  State<Focustime> createState() => _FocustimeState();
}

class _FocustimeState extends State<Focustime> {
  bool isRunning = false;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  Timer? countdownTimer;
  void _showPickerDialog(
    BuildContext context,
    String title,
    int min,
    int max,
    Function(int) onSelected,
  ) {
    int selectedValue = min;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Circular",
              height: 1.2,
            ),
          ),
          content: SizedBox(
            height: 220,
            width: double.maxFinite,
            child: Stack(
              children: [
                CupertinoPicker(
                  itemExtent: 40,
                  diameterRatio: 1.2,
                  magnification: 1.2,
                  backgroundColor: Colors.transparent,
                  onSelectedItemChanged: (int index) {
                    selectedValue = index + min;
                  },
                  children: List<Widget>.generate(max - min + 1, (index) {
                    final value = (min + index).toString().padLeft(2, '0');
                    return Center(
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    );
                  }),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(color: Colors.white24, thickness: 1),
                      SizedBox(height: 38),
                      Divider(color: Colors.white24, thickness: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onSelected(selectedValue);
              },
              child: Text(
                "Select",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Circular",
                  height: 1.2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isRunning ? "Remaining Time" : "Select Time",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Circular",
                height: 1.2,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap:
                          isRunning
                              ? null
                              : () => _showPickerDialog(
                                context,
                                "Select Hours",
                                0,
                                23,
                                (val) {
                                  setState(() {
                                    hours = val;
                                  });
                                },
                              ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(255, 38, 38, 38),
                        ),
                        child: Center(
                          child: Text(
                            "$hours",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Circular",
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      "Hours",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Circular",
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap:
                          isRunning
                              ? null
                              : () => _showPickerDialog(
                                context,
                                "Select Minutes",
                                0,
                                59,
                                (val) {
                                  setState(() {
                                    minutes = val;
                                  });
                                },
                              ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(255, 38, 38, 38),
                        ),
                        child: Center(
                          child: Text(
                            "$minutes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Circular",
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      "Minutes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Circular",
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.height * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 38, 38, 38),
                      ),
                      child: Center(
                        child: Text(
                          "11",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Circular",
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      "Seconds",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Circular",
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            if (isRunning)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      margin: EdgeInsets.symmetric(horizontal: 8),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "Pause",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Circular",
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      margin: EdgeInsets.symmetric(horizontal: 8),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 38, 38, 38),
                      ),
                      child: Center(
                        child: Text(
                          "End Session",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Circular",
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            Container(
              height: MediaQuery.of(context).size.height * 0.07,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  "Start Session",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Circular",
                    height: 1.2,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.card_giftcard, color: Colors.white, size: 29.0),
                SizedBox(width: 6.0),
                Text(
                  "Rewards",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Circular",
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
