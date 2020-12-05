import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polybius Chequerboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Polybius'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String resultText = "Empty";
  String concatText = "";
  int pos1, pos2;
  TextEditingController textController = new TextEditingController();
  var inList = [
    ["A", "B", "C", "D", "E"],
    ["F", "G", "H", "I", "J"],
    ["K", "L", "M", "N", "O"],
    ["P", "R", "S", "T", "U"],
    ["X", "W", "V", "Y", "Z"],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade300, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              margin: EdgeInsets.all(15),
              child: TextFormField(
                controller: textController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: 'Enter Code Here'),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    final n = num.tryParse(textController.text);
                    if (n == null) {
                      resultText = encrptedWord(textController.text);
                    } else {
                      if (checkWord(textController.text) == "0") {
                        resultText = decodeWord(textController.text);
                      } else {
                        resultText = "Wrong Usage";
                      }
                    }
                  });
                },
                child: Text("Check"),
                color: Colors.yellow,
                splashColor: Colors.red.shade300,
                textColor: Colors.deepOrange,
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text("$resultText"),
            ),
          ],
        ),
      ),
    );
  }

  String checkWord(String text) {
    if (text.length % 2 != 0 && text.length == 0) {
      return "1";
    } else
      return "0";
  }

  String decodeWord(String text) {
    String teext = "";
    for (var item in range(0, text.length, 2)) {
      pos1 = int.tryParse(text[item]) - 1;
      pos2 = int.tryParse(text[item + 1]) - 1;
      teext += inList[pos1][pos2];
    }
    return teext;
  }

  String encrptedWord(String text) {
    String textt = "";
    text = text.toUpperCase();
    var b;
    for (int i = 0; i < text.length; i++) {
      b = text[i];
      for (int j = 0; j < 5; j++) {
        for (int k = 0; k < 5; k++) {
          if (b == inList[j][k]) {
            int f = j + 1;
            int s = k + 1;
            textt += "$f $s ";
          }
        }
      }
    }
    return textt;
  }

  String numberValidator(String value) {
    if (int.tryParse(value) > 5) {
      return null;
    }
  }
}
