import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fonts = [
    'OpenSans',
    'Billabong',
    'GrandHotel',
    'Oswald',
    'Quicksand',
    'BeautifulPeople',
    'BeautyMountains',
    'BiteChocolate',
    'BlackberryJam',
    'BunchBlossoms',
    'CinderelaRegular',
    'Countryside',
    'Halimun',
    'LemonJelly',
    'QuiteMagicalRegular',
    'Tomatoes',
    'TropicalAsianDemoRegular',
    'VeganStyle',
  ];
  TextStyle _textStyle = TextStyle(
    fontSize: 50,
    color: Colors.white,
    fontFamily: 'Billabong',
  );
  String _text = 'Sample Text';
  TextAlign _textAlign = TextAlign.center;

  final _textEditorController = TextEditingController();

  void _tapHandler(text, textStyle, textAlign) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(
        milliseconds: 400,
      ), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Container(
          color: Colors.black.withOpacity(0.4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              // top: false,
              child: StatefulBuilder(
                builder: (context, myState) {
                  return TextEditor(
                    onTextChanged: (value) {
                      myState(() => _text = value);
                    },
                    controller: _textEditorController,
                    fonts: fonts,
                    textStyle: textStyle,
                    textAlingment: textAlign,
                    minFontSize: 10,
                    fontDecoration: FontDecoration(
                      size: const Size(28, 28),
                      fontColor: Colors.white,
                      fontActiveColor: Colors.black,
                      radius: BorderRadius.circular(7),
                    ),
                    visibleColorize: false,
                    backgroundColor: Colors.black.withOpacity(0.4),
                    text: _text,
                    maxFontSize: 60,
                    paletteColors: [
                      Colors.black,
                      Colors.white,
                      Colors.blue,
                      Colors.red,
                      Colors.green,
                      Colors.yellow,
                      Colors.pink,
                      Colors.cyanAccent,
                    ],
                    decoration: EditorDecoration(
                      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      bottomSettingDecoration: const BoxDecoration(
                        color: Color.fromRGBO(17, 23, 45, 0.8),
                      ),
                      textBackground: TextBackgroundDecoration(
                        disable: Icon(Icons.text_fields, color: Colors.lightGreen[100]),
                        enable: Icon(Icons.text_fields, color: Colors.white),
                      ),
                      doneButton: Icon(Icons.close, color: Colors.white),
                      fontFamily: Icon(Icons.title, color: Colors.white),
                      colorPalette: Icon(Icons.palette, color: Colors.white),
                      alignment: AlignmentDecoration(
                        left: Icon(Icons.format_align_left_sharp, color: Colors.white),
                        center: Icon(Icons.format_align_center_sharp, color: Colors.white),
                        right: Icon(Icons.format_align_right_sharp, color: Colors.white),
                      ),
                    ),
                    onEditCompleted: (style, align) {
                      setState(() {
                        _textStyle = style;
                        _textAlign = align;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: Center(
          child: Stack(
            children: [
              Image.asset('assets/story.png'),
              Center(
                child: GestureDetector(
                  onTap: () => _tapHandler(_text, _textStyle, _textAlign),
                  child: Text(
                    _text,
                    style: _textStyle,
                    textAlign: _textAlign,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
