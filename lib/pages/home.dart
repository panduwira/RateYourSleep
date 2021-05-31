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
  Duration changedtimer;
  String time = "00:00:00";
  double _rating = 3;
  String name;
  User _auth = FirebaseAuth.instance.currentUser;
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");
  Duration initialtimer = new Duration(hours: 0, minutes: 0, seconds: 0);
  bool autotimestop = true;

  void getUserUpdate() async {
    userCollection.doc(_auth.uid).snapshots().listen((event) {
      name = event.data()['name'];
      setState(() {});
    });
  }

  @override
  void initState() {
    getUserUpdate();
    super.initState();
    var androidInit = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInit = new IOSInitializationSettings();
    var initilizationsSettings =
        new InitializationSettings(android: androidInit, iOS: iOSInit);
    var fltrNotification = new FlutterLocalNotificationsPlugin();
    var notificationSelected;
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future<void> _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "CHANNEL_ID",
      "CHANNEL_NAME",
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);
    await FlutterLocalNotificationsPlugin().show(0, 'Your Data has been saved',
        'Have a nice day', generalNotificationDetails,
        payload: 'test payload');
  }

  Future<void> _showNotification2() async {
    var androidDetails = new AndroidNotificationDetails(
      "CHANNEL_ID",
      "CHANNEL_NAME",
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);
    await FlutterLocalNotificationsPlugin().show(
        0, 'Enjoy Your Sleep', 'Have a nice Sleep', generalNotificationDetails,
        payload: 'test payload2');
  }

  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  static Timestamp timestamp = Timestamp.now();
  static DateTime getStartTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch)
          .toLocal();
  static DateTime getStopTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch)
          .toLocal();
  String startTimeFormat = dateFormat.format(getStartTime);
  String stopTimeFormat = dateFormat.format(getStopTime);

  final onesec = const Duration(seconds: 1);

  @override
  void dispose() {
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

  String setTimer(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
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
      getStartTime = new DateTime.now().toLocal();
    });

    startTimeFormat = dateFormat.format(getStartTime);
    stopwatch.start();
    callTime();
  }

  void timeStop() {
    getStopTime = new DateTime.now().toLocal();
    stopTimeFormat = dateFormat.format(getStopTime);
    getFinalHours();
    getFinalMinutes();
    getFinalSeconds();
    stopwatch.stop();
  }

  void timeReset() {
    stopwatch.reset();
    initialtimer = new Duration(hours: 0, minutes: 0, seconds: 0);
  }

  void clearForm() {
    setState(() {});
  }

  Widget portaitMode() {
    return Container(
        margin: EdgeInsets.all(20),
        child: ListView(children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 150, height: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                  setTimer(initialtimer).substring(0, 5),
                  style: TextStyle(color: Colors.black, fontSize: 32),
                ),
                onPressed: () {
                  if (time == "00:00:00") {
                    showDialog(
                        barrierColor: Colors.blue.withOpacity(0.25),
                        barrierDismissible: true,
                        context: context,
                        builder: (_) => new AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            title: Text(
                              "Set your Timer",
                              style: TextStyle(fontSize: 24.0),
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    height: 150,
                                    width: double.maxFinite,
                                    child: CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hm,
                                      minuteInterval: 1,
                                      secondInterval: 1,
                                      initialTimerDuration: initialtimer,
                                      onTimerDurationChanged: (changedtimer) {
                                        setState(() {
                                          initialtimer = changedtimer;
                                        });
                                      },
                                    )),
                                ListTile(
                                  title: Text("Autostop $autotimestop"),
                                  trailing: Switch(
                                      value: autotimestop,
                                      onChanged: (bool value) {
                                        setState(() {
                                          autotimestop = value;
                                        });
                                      }),
                                ),
                              ],
                            )));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Your timer is stll running",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER_RIGHT,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          SizedBox(height: 16),
          Stack(alignment: Alignment.center, children: [
            CircularPercentIndicator(
              animation: false,
              linearGradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ]),
              radius: 360.0,
              lineWidth: 10.0,
              percent: getSeconds() / 60,
              center:
                  Text(time.substring(0, 5), style: TextStyle(fontSize: 48)),
            ),
          ]),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[startButton(), stopButton()],
          ),
        ]));
  }

  Widget landscapeMode() {
    return Container(
        margin: EdgeInsets.all(20),
        child: ListView(children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 150, height: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                  setTimer(initialtimer).substring(0, 5),
                  style: TextStyle(color: Colors.black, fontSize: 32),
                ),
                onPressed: () {
                  if (time == "00:00:00") {
                    showDialog(
                        barrierColor: Colors.blue.withOpacity(0.25),
                        barrierDismissible: true,
                        context: context,
                        builder: (_) => new AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            title: Text(
                              "Set your Timer",
                              style: TextStyle(fontSize: 24.0),
                              textAlign: TextAlign.center,
                            ),
                            content: Container(
                                height: double.maxFinite,
                                width: 150,
                                child: CupertinoTimerPicker(
                                  mode: CupertinoTimerPickerMode.hm,
                                  minuteInterval: 1,
                                  secondInterval: 1,
                                  initialTimerDuration: initialtimer,
                                  onTimerDurationChanged:
                                      (Duration changedtimer) {
                                    setState(() {
                                      initialtimer = changedtimer;
                                    });
                                  },
                                ))));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Your timer is stll running",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER_RIGHT,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25),
                Stack(alignment: Alignment.center, children: [
                  CircularPercentIndicator(
                    animation: false,
                    linearGradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor
                        ]),
                    radius: 140.0,
                    lineWidth: 10.0,
                    percent: getSeconds() / 60,
                    center: Text(time.substring(0, 5),
                        style: TextStyle(fontSize: 32)),
                  ),
                ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      startButton(),
                      SizedBox(height: 20),
                      stopButton()
                    ]),
              ]),
        ]));
  }

  Widget startButton() {
    return RawMaterialButton(
        elevation: 2.0,
        fillColor: Theme.of(context).buttonColor,
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
            if (time.toString() == setTimer(initialtimer).toString()) {
              Fluttertoast.showToast(
                  msg: "Set your timer first",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER_RIGHT,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              _showNotification2();
              timeStart();
            }
          }
        },
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.play_arrow,
              color: Theme.of(context).primaryIconTheme.color,
              size: 35,
            )));
  }

  Widget stopButton() {
    return RawMaterialButton(
        elevation: 2.0,
        fillColor: Theme.of(context).buttonColor,
        shape: CircleBorder(),
        onLongPress: () {
          timeStop();
          timeReset();
          Fluttertoast.showToast(
              msg: "You have cancelled your sleep timer",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER_RIGHT,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        onPressed: () {
          if (time == "00:00:00") {
            Fluttertoast.showToast(
                msg: "You have not started your sleep timer",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER_RIGHT,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (autotimestop = true) {
            timeStop();
            setState(() {
              cancelButton();
              okButton();
              ratingDialogue();
              /*showDialog(
                  barrierColor: Colors.blue.withOpacity(0.25),
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => new AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0))),
                      actions: [],
                      title: Text(
                        "How was your sleep, " + name + "?",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                      content: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                  child: ListTile(
                                title: Text('Start Time '),
                                trailing: Text(startTimeFormat),
                              )),
                              Container(
                                  child: ListTile(
                                title: Text('End Time '),
                                trailing: Text(stopTimeFormat),
                              )),
                              Container(
                                  child: ListTile(
                                title: Text('Length '),
                                trailing: Text(time),
                              )),
                              Center(
                                child: RatingBar.builder(
                                  glowColor: Colors.yellow,
                                  itemCount: 5,
                                  initialRating: 3,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemBuilder: (context, _) {
                                    switch (_) {
                                      case 0:
                                        return Icon(
                                          Icons.star,
                                          color: Colors.red[900],
                                        );
                                      case 1:
                                        return Icon(
                                          Icons.star,
                                          color: Colors.red,
                                        );
                                      case 2:
                                        return Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        );
                                      case 3:
                                        return Icon(
                                          Icons.star,
                                          color: Colors.green[400],
                                        );
                                      case 4:
                                        return Icon(
                                          Icons.star,
                                          color: Colors.green[200],
                                        );
                                    }
                                  },
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      _rating = rating;
                                    });
                                  },
                                ),
                              ),
                              okButton(),
                              cancelButton()
                            ]),
                      ))); */
            });
          } else {
            timeStop();
            setState(() {
              cancelButton();
              okButton();
              ratingDialogue();
              /*showDialog(
                  barrierColor: Colors.blue.withOpacity(0.25),
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => new AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0))),
                        actions: [],
                        title: Text(
                          "How was your sleep, " + name + "?",
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                        content: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                    child: ListTile(
                                  title: Text('Start Time '),
                                  trailing: Text(startTimeFormat),
                                )),
                                Container(
                                    child: ListTile(
                                  title: Text('End Time '),
                                  trailing: Text(stopTimeFormat),
                                )),
                                Container(
                                    child: ListTile(
                                  title: Text('Length '),
                                  trailing: Text(time),
                                )),
                                Center(
                                  child: RatingBar.builder(
                                    glowColor: Colors.yellow,
                                    itemCount: 5,
                                    initialRating: 3,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemBuilder: (context, _) {
                                      switch (_) {
                                        case 0:
                                          return Icon(
                                            Icons.star,
                                            color: Colors.red[900],
                                          );
                                        case 1:
                                          return Icon(
                                            Icons.star,
                                            color: Colors.red,
                                          );
                                        case 2:
                                          return Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          );
                                        case 3:
                                          return Icon(
                                            Icons.star,
                                            color: Colors.green[400],
                                          );
                                        case 4:
                                          return Icon(
                                            Icons.star,
                                            color: Colors.green[200],
                                          );
                                      }
                                    },
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        _rating = rating;
                                      });
                                    },
                                  ),
                                ),
                                okButton(),
                                cancelButton()
                              ]),
                        ),
                      ));*/
            });
          }
        },
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.stop,
              color: Theme.of(context).primaryIconTheme.color,
              size: 35,
            )));
  }

  Widget cancelButton() {
    return MaterialButton(
      color: Colors.redAccent,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: Text(
        "Discard",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        timeReset();
      },
      onLongPress: () {
        Fluttertoast.showToast(
            msg: "Push this button if you don't want to save your sleep data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }

  Widget okButton() {
    return MaterialButton(
      color: Colors.greenAccent,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: Text(
        "Save",
        style: TextStyle(color: Colors.white),
      ),
      onLongPress: () {
        Fluttertoast.showToast(
            msg: "Push this button if you want to save your sleep data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_RIGHT,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
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
          SleepTimer sleepTimer = SleepTimer("", time, hours, minutes, seconds,
              _rating.toString(), name, startTimeFormat, stopTimeFormat);
          bool result = await SleepTimerServices.addTimer(sleepTimer);
          if (result == true) {
            _showNotification();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ListDataPage();
            }));
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
  }

  void ratingDialogue() {
    showDialog(
        barrierColor: Colors.blue.withOpacity(0.25),
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              actions: [],
              title: Text(
                "How was your sleep, " + name + "?",
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
              content: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          child: ListTile(
                        title: Text('Start Time '),
                        trailing: Text(startTimeFormat),
                      )),
                      Container(
                          child: ListTile(
                        title: Text('End Time '),
                        trailing: Text(stopTimeFormat),
                      )),
                      Container(
                          child: ListTile(
                        title: Text('Length '),
                        trailing: Text(time),
                      )),
                      Center(
                        child: RatingBar.builder(
                          glowColor: Colors.yellow,
                          itemCount: 5,
                          initialRating: 3,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemBuilder: (context, _) {
                            switch (_) {
                              case 0:
                                return Icon(
                                  Icons.star,
                                  color: Colors.red[900],
                                );
                              case 1:
                                return Icon(
                                  Icons.star,
                                  color: Colors.red,
                                );
                              case 2:
                                return Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                );
                              case 3:
                                return Icon(
                                  Icons.star,
                                  color: Colors.green[400],
                                );
                              case 4:
                                return Icon(
                                  Icons.star,
                                  color: Colors.green[200],
                                );
                            }
                          },
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
                      ),
                      okButton(),
                      cancelButton()
                    ]),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return portaitMode();
      } else {
        return landscapeMode();
      }
    }));
  }
}
