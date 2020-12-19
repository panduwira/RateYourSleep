part of 'pages.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final ratingcontroller = TextEditingController();
  bool startTime = false;
  bool stopTime = false;
  bool resetTime = false;

  int hours, minutes, seconds;
  Stopwatch stopwatch = Stopwatch();
  String time = "00:00:00";
  final onesec = const Duration(seconds: 1);

  @override
  void dispose() {
    stopwatch.reset();
    super.dispose();
  }

  void callTime() {
    Timer(onesec, timeChange);
  }

  void timeChange() {
    setState(() {
      time = getTime();
    });
    callTime();
  }

  void getFinalHours() {
    setState(() {
      hours = getHour();
    });
    callTime();
  }

  String getTime() {
    return (stopwatch.elapsed.inHours.toString().padLeft(2, "0") +
        ":" +
        (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0"));
  }

  int getHour() {
    return stopwatch.elapsed.inHours.toInt();
  }

  int getMinutes() {
    return stopwatch.elapsed.inMinutes % 60.toInt();
  }

  int getSeconds() {
    return stopwatch.elapsed.inSeconds % 60.toInt();
  }

  void timeStart() {
    setState(() {
      startTime = true;
    });
    stopwatch.start();
    callTime();
  }

  void timeStop() {
    stopwatch.stop();
  }

  void timeReset() {
    stopwatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    void clearForm() {
      setState(() {
        ratingcontroller.clear();
      });
    }
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
                    
                    fontSize: 48,
                  ),
                ),
              ),
              Container(
                width: 85,
                height: 92,
                color: Color(0xffc4c4c4),
                child: Center(
                  child: Text(
                    time,
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
              RaisedButton.icon(
                onPressed: () {
                  timeStart();
                },
                icon: Icon(Icons.timer),
                label: Text('Sleep'),
                color: Colors.black,
                textColor: Colors.white,
              ),
              RaisedButton.icon(
                onPressed: () {
                  timeStop();
                  setState(() {
                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        timeReset();
                        clearForm();
                      },
                    );
                    showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                                actions: [
                                  okButton,
                                ],
                                title: Text('Rate Your Sleep'),
                                content: Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(time),
                                        Text("How's your sleep"),
                                        TextFormField(
                                          controller: ratingcontroller,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0)),
                                        ),
                                        Text("/5")
                                      ]),
                                )));
                  });
                },
                icon: Icon(Icons.timer),
                label: Text('Wake Up'),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ])));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        timeReset();
      },
    );

    // set up the AlertDialog

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rate Your Sleep"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('test'), Text('test')],
            ),
          ),
          //Text("How was Your Sleep ?" + time),

          actions: [
            okButton,
          ],
        );
      },
    );
  }
}
