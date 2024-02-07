import 'package:flutter/material.dart';

void main() {
  runApp(BZCalculator());
}

class BZCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  CalculatorHomePageState createState() => CalculatorHomePageState();
}

class CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _outputHistory = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    print(buttonText);
    if (buttonText == "CLEAR") {
      _output = "0";
      _outputHistory = "";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      num1 = double.parse(_output);
      operand = buttonText;
      _outputHistory = _outputHistory + buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "*") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      print("before $_output");
      _output = (double.parse(_output)*10 + double.parse(buttonText)).toString();
      print("after $_output");
    }

    setState(() {
      _output = double.parse(_output).toStringAsFixed(2);

    });
  }

  Widget buildButton(String buttonText,{Color buttonColor = Colors.white10}) {
    return Expanded(
      child: ElevatedButton(
        style : ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99.0)
                )
            ),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(25)),

        ),
        child: Text(
          buttonText,
          style: TextStyle(color : Colors.white,fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        titleTextStyle: TextStyle(color: Colors.green, fontSize: 24.0, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black,
      ),
      body:
        Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _outputHistory,
              style: TextStyle(color:Colors.white,fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            color: Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/",buttonColor:Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*",buttonColor:Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-",buttonColor:Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("+",buttonColor:Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("CLEAR",buttonColor:Colors.grey),
                  buildButton("=",buttonColor:Colors.grey),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
