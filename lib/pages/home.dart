part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int hours = 0, minutes = 0, seconds = 0;
  int secondsplus;

  bool startStop = false;
  static Timer time;
  static const onesec = const Duration(seconds: 1);

  void initState() {
    super.initState();
    if (time == null)
      time = Timer.periodic(onesec, (Timer t) {
        startTimer();
      });
  }

  void startTimer() {
    if (startStop) {
      setState(() {
        secondsplus = secondsplus + 1;
        seconds = secondsplus % 60;
        minutes = secondsplus ~/ 60 % 60;
        hours = secondsplus ~/ (60 * 60) % 24;
      });
    }
  }

  void stopTimer() {}

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
                        hours.toString().padLeft(2, "0"),
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
                        minutes.toString().padLeft(2, "0"),
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
                        seconds.toString().padLeft(2, "0"),
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
              onPressed: () {
                setState(() {
                  startStop = !startStop;
                });
              },
              icon: Icon(Icons.timer),
              label: Text(startStop ? 'Stop' : 'Start'),
              color: Colors.black,
              textColor: Colors.white,
            ),
          ])),
    );
  }
}
