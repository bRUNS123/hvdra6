import 'package:flutter/material.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  int _selection = 0;

  void selectTime(int? timeSelected) {
    setState(() {
      print(timeSelected);
      _selection = timeSelected!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selection = 1;
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 150,
                          color: _selection == 1 ? Colors.green : Colors.white,
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              focusColor: Colors.white,
                              groupValue: _selection,
                              onChanged: selectTime,
                              value: 1,
                            ),
                            const Text(
                              "11:00 - 12:00",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selection = 2;
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 150,
                          color: _selection == 2 ? Colors.green : Colors.white,
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              focusColor: Colors.white,
                              groupValue: _selection,
                              onChanged: selectTime,
                              value: 2,
                            ),
                            const Text(
                              "12:00 - 13:00",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    ));
  }
}
