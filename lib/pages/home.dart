part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Your Sleep"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(children: <Widget>[
            SizedBox(
              width: 359,
              height: 71,
              child: Text(
                "Sleep Timer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: (){},
              icon: Icon(Icons.timer),
              label: Text("Start/Stop"),
              )
          ])),
    );
  }
}
