part of 'pages.dart';

class HomeSettings extends StatefulWidget {
  HomeSettings(
      //{Key key}) : super(key: key
      );

  @override
  _HomeSettingsState createState() => _HomeSettingsState();
}

class _HomeSettingsState extends State<HomeSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Settings"),
            centerTitle: true,
            leading: new IconButton(
              icon: Icon(
                Icons.arrow_left,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return MainMenu();
                }));
              },
            )),
        body: Stack(alignment: Alignment.topLeft, children: <Widget>[
            ElevatedButton(
              child: Text("Theme Dialog"),
              onPressed: () {
                showDialog(
                  context: context, builder: (_) => 
                  ThemeDialog(
                  animatedOpacityDuration: 1,
                  
                ));
              },
            ),
        ]));
  }
}
