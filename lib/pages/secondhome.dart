part of 'pages.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool startTime = false;
  bool stopTime = false;
  bool resetTime = false;

  int hours, minutes, seconds;
  Stopwatch stopwatch = Stopwatch();
  String time = "00:00:00";
  double _rating;
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

  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
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
                  if (time != "00:00:00") {
                    Fluttertoast.showToast(
                        msg: "You're Time is stll running",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER_RIGHT,
                        backgroundColor: Colors.black,
                        textColor: Colors.yellow,
                        fontSize: 16.0);
                  } else {
                    timeStart();
                    Fluttertoast.showToast(
                        msg: "Your Sleep has been started",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER_RIGHT,
                        backgroundColor: Colors.black,
                        textColor: Colors.yellow,
                        fontSize: 16.0);
                  }
                },
                icon: Icon(Icons.timer),
                label: Text('Sleep'),
                color: Colors.black,
                textColor: Colors.white,
              ),
              RaisedButton.icon(
                onPressed: () {
                  if (time == "00:00:00") {
                    Fluttertoast.showToast(
                        msg: "You're not yet to start your sleep timer",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER_RIGHT,
                        backgroundColor: Colors.black,
                        textColor: Colors.yellow,
                        fontSize: 16.0);
                  } else {
                    timeStop();
                    setState(() {
                      Widget cancelButton = FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          timeReset();
                          Fluttertoast.showToast(
                              msg: "Your Sleep has been unsaved",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER_RIGHT,
                              backgroundColor: Colors.red,
                              textColor: Colors.yellow,
                              fontSize: 16.0);
                        },
                      );
                      Widget okButton = FlatButton(
                        child: Text("OK"),
                        onPressed: () async {
                          if (_rating == 0) {
                            Fluttertoast.showToast(
                                msg: "Please rate your sleep :-)",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER_RIGHT,
                                backgroundColor: Colors.black,
                                textColor: Colors.yellow,
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
                            );
                            bool result =
                                await SleepTimerServices.addTimer(sleepTimer);
                            if (result == true) {
                              Fluttertoast.showToast(
                                  msg: "Your Sleep has been saved :-)",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER_RIGHT,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.yellow,
                                  fontSize: 16.0);
                              timeReset();
                              clearForm();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Failed :-)",
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
                                  title: Text('How was Your Sleep, ' + name ??
                                                '' + '?', style: TextStyle(fontSize: 30.0),),
                                  content: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(startTimeFormat),
                                          Text(stopTimeFormat),
                                          Text(hours.toString() +
                                              " Hours " +
                                              minutes.toString() +
                                              " Minutes"),
                                          Text(time),
                                          RatingBar.builder(
                                            itemCount: 5,
                                            initialRating: 3,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                this._rating = rating;
                                              });
                                            },
                                          ),
                                          Text(_rating.toString()),
                                          _rating != null
                                              ? Text(
                                                  'Rating: ' +
                                                      _rating.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Container(),
                                        ]),
                                  )));
                    });
                  }
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
