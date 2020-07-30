import 'package:flutter/material.dart';
//For make icon package.
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
//For url_launcher Package.
import 'package:url_launcher/url_launcher.dart';
//For use NoSQL Database package.
import 'package:shared_preferences/shared_preferences.dart'; // 追記する

//constitution
//main->Myapp->AppMain->_AppMainState

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tllist',
      theme: ThemeData(
      ),
      home: AppMain(title: 'tllist'),
    );
  }
}

class AppMain extends StatefulWidget{

  AppMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {

  //These code is not need before widget.
  //No problem even after the widget.
  //However, do not write it outside of _AppMainState~{}.
  //Prepare for link. https://pub.dev/packages/link
  _launchURL() async {
    const url = 'https://9vox2.netlify.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

  //Prepare for use NoSQL, this code make controller.
  final redController = TextEditingController();//Controller for red
  final yellowController = TextEditingController();//Controller for yellow
  final greenController = TextEditingController();//Controller for green
  var isLoaded = false;//

  //Prepare for load().
  //There is no problem if there are multiple @overrude.
  @override
  void initState() {
    super.initState();
    load();
  }

  //load function
  Future<void> load() async {
    final prefs1 = await SharedPreferences.getInstance();
    redController.text = prefs1.getString('red');
    yellowController.text = prefs1.getString('yellow');
    greenController.text = prefs1.getString('green');
    setState(() {
      isLoaded = true;
    });
  }

  //save function
  Future<void> save(key, text) async {
    final prefs2 = await SharedPreferences.getInstance();
    await prefs2.setString(key, text);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  //Widget:All drawings on the screen will be displayed exactly as written here.
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Visibility(
          visible: isLoaded,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(''),
                Text(''),
                Text('tllist'),
                Text(''),
                //ASAPfill ASAP is an abbreviation for as soon as possible.
                TextField(
                    controller: redController,
                    onChanged: (text) {
                      save('red', text);
                    },
                    minLines: 4,
                    maxLines: 4,
                    maxLength: 150,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      fillColor: Colors.red[200],
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: '緊急/ASAP',
                    )),
                //ImportantFill
                TextField(
                    controller: yellowController,
                    onChanged: (text) {
                      save('yellow', text);
                    },
                    minLines: 6,
                    maxLines: 6,
                    maxLength: 250,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      fillColor: Colors.yellow[300],
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: '重要/Important',
                    )),
                //Otherfill
                TextField(
                    controller: greenController,
                    onChanged: (text) {
                      save('green', text);
                    },
                    minLines: 8,
                    maxLines: 8,
                    maxLength: 350,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      fillColor: Colors.green[300],
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'その他/Other',
                    )),
                Text(''),
                //Link
                RaisedButton(
                  onPressed: _launchURL,
                  child: Text('ABOUT'),
                ),
              ],
            ),
          ),
        ));
  }
}