part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool startTime = false;
  bool stopTime = false;
  bool resetTime = false;

  int hours, minutes, seconds;
  Stopwatch stopwatch = Stopwatch();
  String time = "00:00:00";
  double _rating = 3;
  String name;
  User _auth = FirebaseAuth.instance.currentUser;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  void getUserUpdate() async {
    userCollection.doc(_auth.uid).snapshots().listen((event) {
      name = event.data()['name'];
      setState(() {});
    });
  }

  void initState() {
    getUserUpdate();
    super.initState();
  }

  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  static Timestamp timestamp = Timestamp.now();
  static DateTime getStartTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  static DateTime getStopTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  String startTimeFormat = dateFormat.format(getStartTime);
  String stopTimeFormat = dateFormat.format(getStopTime);

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

  void getFinalMinutes() {
    setState(() {
      minutes = getMinutes();
    });
    callTime();
  }

  void getFinalSeconds() {
    setState(() {
      seconds = getSeconds();
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
      getStartTime = new DateTime.now();
    });

    startTimeFormat = dateFormat.format(getStartTime);
    stopwatch.start();
    callTime();
  }

  void timeStop() {
    getStopTime = new DateTime.now();
    stopTimeFormat = dateFormat.format(getStopTime);
    getFinalHours();
    getFinalMinutes();
    getFinalSeconds();
    stopwatch.stop();
  }

  void timeReset() {
    stopwatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    void clearForm() {
      setState(() {});
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
              SizedBox(height: 64),
              SizedBox(
                width: 359,
                child: Text(
                  "Sleep Timer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
              ),
              SizedBox(height: 32),
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
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                      elevation: 2.0,
                      fillColor: Colors.green,
                      shape: CircleBorder(),
                      onPressed: () {
                        if (time != "00:00:00") {
                          Fluttertoast.showToast(
                              msg: "Your timer is stll running",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER_RIGHT,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          timeStart();
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 35,
                          ))),
                  RawMaterialButton(
                      elevation: 2.0,
                      fillColor: Colors.red,
                      shape: CircleBorder(),
                      onPressed: () {
                        if (time == "00:00:00") {
                          Fluttertoast.showToast(
                              msg: "You have not started your sleep timer",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER_RIGHT,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          timeStop();
                          setState(() {
                            Widget cancelButton = FlatButton(
                              child: Text("Discard"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                timeReset();
                              },
                            );
                            Widget okButton = FlatButton(
                              child: Text("Save"),
                              onPressed: () async {
                                if (_rating == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please rate your sleep",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER_RIGHT,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  SleepTimer sleepTimer = SleepTimer(
                                      "",
                                      time,
                                      hours,
                                      minutes,
                                      seconds,
                                      _rating.toString(),
                                      name,
                                      startTimeFormat,
                                      stopTimeFormat);
                                  bool result =
                                      await SleepTimerServices.addTimer(
                                          sleepTimer);
                                  if (result == true) {
                                    Fluttertoast.showToast(
                                        msg: "Your sleep data has been saved",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER_RIGHT,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    timeReset();
                                    clearForm();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Failed to save data",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER_RIGHT,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.yellow,
                                        fontSize: 16.0);
                                  }
                                }
                                Navigator.of(context).pop();
                              },
                            );
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => new AlertDialog(
                                        actions: [
                                          cancelButton,
                                          okButton,
                                        ],
                                        title: Text(
                                          "How was your sleep, " + name + "?",
                                          style: TextStyle(fontSize: 24.0),
                                        ),
                                        content: Container(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text("Start time: " +
                                                    startTimeFormat),
                                                Text("End time: " +
                                                    stopTimeFormat),
                                                Text("Length: " + time),
                                                Text(""),
                                                Text("Rating"),
                                                RatingBar.builder(
                                                  itemCount: 5,
                                                  initialRating: 3,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    setState(() {
                                                      _rating = rating;
                                                    });
                                                  },
                                                ),
                                              ]),
                                        )));
                          });
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 35,
                          ))),
                ],
              ),
            ])));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Save"),
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
