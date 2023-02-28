import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var closePopover = false;
  @override
  Widget build(BuildContext context) {
    if (closePopover) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).popUntil((route) {
          return route.settings.name != null;
        });
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showGeneralDialog(
                    context: context,
                    pageBuilder: (context, _, __) {
                      return OrientationBuilder(builder: (_, orientation) {
                        if (orientation != Orientation.portrait) {
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            setState(() {
                              closePopover = true;
                            });
                          });
                        }
                        return Text('popover');
                      });
                    });
              },
              child: Text('Tap'),
            ),
          ],
        ),
      ),
    );
  }
}
