part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int hours = 0, minutes = 0, seconds = 0;

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
            SizedBox(height: 120),
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
                        hours.toString(),
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Sans Serif",
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(fontSize: 48),
                  ),
                  Container(
                    width: 85,
                    height: 92,
                    color: Color(0xffc4c4c4),
                    child: Center(
                      child: Text(
                        minutes.toString(),
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Sans Serif",
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(fontSize: 48),
                  ),
                  Container(
                    width: 85,
                    height: 92,
                    color: Color(0xffc4c4c4),
                    child: Center(
                      child: Text(
                        seconds.toString(),
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Sans Serif",
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]),
            SizedBox(height: 20),
            RaisedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.timer),
              label: Text("Start/Stop"),
              color: Colors.black,
              textColor: Colors.white,
            ),
          ])),
    );
  }
}
