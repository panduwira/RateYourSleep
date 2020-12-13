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
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 85,
                    height: 92,
                    color: Color(0xffc4c4c4),
                    child: Center(
                      child: Text(
                        '00',
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Sans Serif",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    height: 92,
                    color: Color(0xffc4c4c4),
                    child: Center(
                      child: Text(
                        '00',
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Sans Serif",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: 85,
                    height: 92,
                    color: Color(0xffc4c4c4),
                    child: Center(
                      child: Text(
                        '00',
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Sans Serif",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]),
            RaisedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.timer),
              label: Text("Start/Stop"),
            ),
          ])),
    );
  }
}
