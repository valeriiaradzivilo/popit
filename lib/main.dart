import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'PopIt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

  deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  List<List<bool>> pressedButtons = [];






  SizedBox popsButtons(BuildContext context, Color color, int j, int i ) {
    return SizedBox(
      height: deviceWidth(context) / 10,
      width: deviceWidth(context) / 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),

          child: Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  gradient: pressedButtons[i][j]==true?RadialGradient(
                    stops: [
                      0.7,
                      0.9,
                    ],
                    colors: [
                      Colors.black26,
                      color,
                    ],
                  ):null,
                  borderRadius: BorderRadius.circular(100.0)), //<-- SEE HERE
              child: InkWell(
                borderRadius: BorderRadius.circular(100.0),
                onTap: () {
                  setState(() {
                      pressedButtons[i][j] = !pressedButtons[i][j];
                      SystemSound.play(SystemSoundType.click);
                  });
                  SystemSound.play(SystemSoundType.alert);
                },
                child: null,
              ),
            ),
          ),
      ),
    );
  }
  var random = Random();
  List<Color> colors = [];

  _makeColors()
  {
    for(int i =0; i<8;i++)
      {
        colors.add(Color.fromARGB(200, random.nextInt(255),
            random.nextInt(255),
            random.nextInt(255)));
        List<bool> bPress = [];
        for(int j =0; j<8;j++)
          {
            bPress.add(false);
          }
        pressedButtons.add(bPress);
      }
  }

  @override
  Widget build(BuildContext context) {
  _makeColors();
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top:100.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  for(int j =0; j<8;j++)
              Container(
                width: deviceWidth(context)/1.2,
              color: colors.elementAt(j),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      for(int i =0; i<8;i++)
                          popsButtons(context, colors.elementAt(j),j,i),

                  ]
                  )
              )
                ] ,
            ),
          ),
        ),
      )
    );
  }
}
