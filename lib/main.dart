import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: MyStateLessHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum TimeToLive {
  tenMinutes,
  oneHour,
  oneDay,
  oneWeek,
  oneMonth,
  oneYear
}

extension TimeToLiveExt on TimeToLive {
  String get name {
    switch (this) {
      case TimeToLive.tenMinutes:
        return '10分';
      case TimeToLive.oneHour:
        return '1時間';
      case TimeToLive.oneDay:
        return '1日';
      case TimeToLive.oneWeek:
        return '1週間';
      case TimeToLive.oneMonth:
        return '1ヶ月';
      case TimeToLive.oneYear:
        return '1年';
    }
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // String _type = '奇数';

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print('helloworld');
      // _type = _counter % 2 == 0 ? '偶数' : '奇数';
    });
  }

  double _progress = 0;
  void _incrementProgress() {
    setState(() {
      print(_progress);

      if (_progress == 1.0) {
        _progress = 0;
      } else {
        _progress += 0.2;
      }
    });
  }

  // ドロワー内メニュー用
  bool _isIncludeAniv = false;
  bool _isIncludeEvent = false;
  bool _isIncludeBirthdays = false;
  bool _isIncludeMyBirthday = false;

  // 日付選択ドラムロール用
  DateTime targetDate = DateTime(2023);

  // 時間選択ドロップダウン用
  var _selectDuration = '10分';
  void _changeDuration(String? selectedValue) {
    setState(() {
      _selectDuration = selectedValue ?? '10分';
    });
  }

  // テキストフィールド用
   final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  String memo = '';

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(children: const [
          Icon(Icons.create),
          Text('Title with Icon'),
        ]),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(children: [
          Image.asset('assets/images/sample.jpeg'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: _selectDuration,
                onChanged: _changeDuration,
                items: TimeToLive.values
                  .map((v) =>
                    DropdownMenuItem<String>(value: v.name, child: Text(v.name)))
                  .toList(),
              ),
              Expanded(
                child: TextFormField(
                  enabled: true,
                  focusNode: _focusNode,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'メモ',
                  ),
                  onChanged: (String value) {
                    memo = value;
                  },
                ),
              ),
            ],
          ),
          // IconButton(
          //   icon: const Icon(Icons.add),
          //   onPressed: () async {
          //     final Uri url = Uri.parse('https://www.google.com/');
          //     if (await canLaunchUrl(url)) {
          //       await launchUrl(
          //         url,
          //         mode: LaunchMode.externalApplication,
          //       );
          //     }
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(
          //     FontAwesomeIcons.solidCalendar,
          //     color: Colors.blue,
          //     size: 30.0,
          //   ),
          //   onPressed: () {
          //     DatePicker.showDatePicker(context,
          //       showTitleActions: true,
          //       minTime: DateTime(1900, 1, 1),
          //       maxTime: DateTime(2099, 12, 31),
          //       onConfirm: (date) {
          //         setState(() {
          //           targetDate = date;
          //         });
          //       },
          //       currentTime: targetDate,
          //       locale: LocaleType.jp,
          //     );
          //   },
          // ),
          // Stack(children: [
          //   SizedBox(
          //     child: LinearProgressIndicator(
          //       minHeight: 30.0,
          //       backgroundColor: Colors.grey,
          //       valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          //       value: _progress,
          //     ),
          //   ),
          //   Align(
          //     child: 
          //     (_progress == 1.0)
          //       ? const Text(
          //           '完了',
          //           style: const TextStyle(
          //             fontSize: 20.0,
          //             color: Colors.white,
          //           ),
          //         )
          //       : Text(
          //           'あと${((1 - _progress) * 100).toStringAsFixed(1)}%',
          //           style: const TextStyle(
          //             fontSize: 20,
          //             color: Colors.white,
          //           ),
          //         ),
          //   ),
          // ]),
          // TextButton(
          //   onPressed: () => _incrementProgress(),
          //   child: const Text('インジゲーター用ボタン'),
          // ),
          // Container(
          //   padding: const EdgeInsets.all(10.0),
          //   child: const SizedBox(
          //     width: 100,
          //     height: 100,
          //     child: CircularProgressIndicator(
          //       strokeWidth: 10.0,
          //     ),
          //   ),
          // ),
          // const Icon(FontAwesomeIcons.gift, color: Colors.teal),
          // Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          // // Text('$_type', style: const TextStyle(fontSize: 20, color: Colors.red)),
          // if (_counter % 2 == 0)
          //   const Text('Odd!', style: TextStyle(fontSize: 20, color: Colors.red)),
          // const Text('Hello world'),
          // const Text('ハローワールド'),
          // TextButton(
          //   onPressed: () => {print('button is pressed')},
          //   child: const Text('テキストボタン'),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: const [
          //     Icon(
          //       Icons.favorite,
          //       color: Colors.pink,
          //       size: 24.0,
          //     ),
          //     Icon(
          //       Icons.audiotrack,
          //       color: Colors.green,
          //       size: 30.0,
          //     ),
          //     Icon(
          //       Icons.beach_access,
          //       color: Colors.blue,
          //       size: 36.0,
          //     ),
          //   ],
          // ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('booomb');
          _incrementCounter();
        },
        child: const Icon(Icons.timer),
      ),
      drawer: const Drawer(child: Center(child: Text('drawer'))),
      endDrawer: Drawer(
        child: ListView(children: <Widget>[
          SwitchListTile(
            title: const Text('記念日'),
            value: _isIncludeAniv,
            onChanged: (bool value) {
              setState(() {
                _isIncludeAniv = value;
              });
            },
            secondary: const Icon(FontAwesomeIcons.gift, color: Colors.teal),
          ),
          SwitchListTile(
            title: const Text('イベント'),
            value: _isIncludeEvent,
            onChanged: (bool value) {
              setState(() {
                _isIncludeEvent = value;
              });
            },
            secondary: const Icon(FontAwesomeIcons.circleInfo, color: Colors.blue),
          ),
          SwitchListTile(
            title: const Text('誕生日'),
            value: _isIncludeBirthdays,
            onChanged: (bool value) {
              setState(() {
                _isIncludeBirthdays = value;
              });
            },
            secondary: const Icon(FontAwesomeIcons.cakeCandles, color: Colors.pink),
          ),
          SwitchListTile(
            title: const Text('あなたの生まれた日'),
            value: _isIncludeMyBirthday,
            onChanged: (bool value) {
              setState(() {
                _isIncludeMyBirthday = value;
              });
            },
            secondary: const Icon(FontAwesomeIcons.solidStar, color: Colors.amber),
          ),
        ]),
      ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyStateLessHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless HomePage.'),
      ),
      body: const Text('書き換えしないページ'),
    );
  }
}
