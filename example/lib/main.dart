import 'package:flutter/material.dart';
import 'package:diamond_dial_fab/diamond_dial_fab.dart';
import 'package:diamond_dial_fab/diamond_dial_fab_child.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext cokntext) {
    return MaterialApp(
      title: 'Diamond FAB',
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
      home: const MyHomePage(title: 'Diamond Dial FAB Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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

class _MyHomePageState extends State<MyHomePage> {
  FloatingActionButtonLocation _fabLocation = FloatingActionButtonLocation.centerFloat;
  LabelLocation _labelLocation = LabelLocation.left;
  double _cornerRadius = 2.0;
  DimOverlay _dimOverlay = DimOverlay.none;

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
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Diamond Corner Radius ${_cornerRadius.round()}'),
            Slider(
              label: '${_cornerRadius.round()}',
              value: _cornerRadius,
              min: 0,
              max: 30,
              onChanged: (value) {
                  setState(() {
                      _cornerRadius = value;
                    });
            }),
            const Text('Fab Location'),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title : const Text('Left'),
                    value: FloatingActionButtonLocation.startFloat,
                    groupValue: _fabLocation,
                    onChanged: (value) {
                      setState(() {
                        _fabLocation = value as FloatingActionButtonLocation;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title : const Text('Center'),
                    value: FloatingActionButtonLocation.centerFloat,
                    groupValue: _fabLocation,
                    onChanged: (value) {
                      setState(() {
                        _fabLocation = value as FloatingActionButtonLocation;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title : const Text('Right'),
                    value: FloatingActionButtonLocation.endFloat,
                    groupValue: _fabLocation,
                    onChanged: (value) {
                      setState(() {
                        _fabLocation = value as FloatingActionButtonLocation;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Text('Label Location'),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title : const Text('Left'),
                    value: LabelLocation.left,
                    groupValue: _labelLocation,
                    onChanged: (value) {
                      setState(() {
                        _labelLocation = value as LabelLocation;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title : const Text('Right'),
                    value: LabelLocation.right,
                    groupValue: _labelLocation,
                    onChanged: (value) {
                      setState(() {
                        _labelLocation = value as LabelLocation;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Text('Dim Overlay'),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title : const Text('None'),
                    value: DimOverlay.none,
                    groupValue: _dimOverlay,
                    onChanged: (value) {
                      setState(() {
                        _dimOverlay = value as DimOverlay;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title : const Text('Dark'),
                    value: DimOverlay.dark,
                    groupValue: _dimOverlay,
                    onChanged: (value) {
                      setState(() {
                        _dimOverlay = value as DimOverlay;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title : const Text('Light'),
                    value: DimOverlay.light,
                    groupValue: _dimOverlay,
                    onChanged: (value) {
                      setState(() {
                        _dimOverlay = value as DimOverlay;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: _fabLocation,
      floatingActionButton: DiamondDialFab(
        cornerRadius: _cornerRadius,
        childLabelLocation: _labelLocation,
        dimOverlay: _dimOverlay,
        dimOpacity: 0.5,
        mainIcon: const Icon(Icons.account_balance_sharp),
        pressedIcon: const Icon(Icons.close),
        pressedBackgroundColor: Colors.white,
        pressedForegroudColor: Colors.amber,
        mainBackgroundColor: Colors.amber,
        children: [
          DiamondDialChild(
            child: const Icon(Icons.wine_bar),
            label: "Wine Bar",
          ),
          DiamondDialChild(
              child: const Icon(Icons.wc),
              label: "Toilet"
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
