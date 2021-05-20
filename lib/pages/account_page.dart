part of "pages.dart";

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isLoading = false;
  User _auth = FirebaseAuth.instance.currentUser;
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");
  CollectionReference<Map<String, dynamic>> productCollection =
      FirebaseFirestore.instance.collection("products");
  String img, name, email;

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  List<charts.Series<SleepTimerChart, String>> _seriesBarData;
  List<SleepTimerChart> mydata;

  _generateData(mydata) {
    // ignore: deprecated_member_use
    _seriesBarData = List<charts.Series<SleepTimerChart, String>>();
    _seriesBarData.add(
      charts.Series(
          data: mydata,
          id: 'Sleep Data',
          displayName: 'Sleep Data',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          measureFn: (SleepTimerChart st, _) => st.hours,
          domainFn: (SleepTimerChart st, _) => st.sleepdate.toString(),
          labelAccessorFn: (SleepTimerChart strow, _) =>
              "${strow.sleepdate.toString()}"),
    );
  }

  Future<int> totalfunction() async {
    // Code returning Integer value from Await function Call
    QuerySnapshot productSnapshot = await FirebaseFirestore.instance
        .collection('timer')
        .where("username", isEqualTo: name)
        .get();

    return productSnapshot.docs.length;
  }

  Future<int> totalhoursfunction() async {
    var totalhours = 0;
    QuerySnapshot<Map<String, dynamic>> productSnapshot =
        await FirebaseFirestore.instance
            .collection('timer')
            .where("username", isEqualTo: name)
            .get();
    productSnapshot.docs.forEach((doc) {
      totalhours = totalhours + doc.data()['hours'];
    });
    return totalhours;
  }

  Future<double> totalhoursratefunction() async {
    double totalhours = 0;
    QuerySnapshot<Map<String, dynamic>> productSnapshot =
        await FirebaseFirestore.instance
            .collection('timer')
            .where("username", isEqualTo: name)
            .get();
    productSnapshot.docs.forEach((doc) {
      totalhours = totalhours +
          (doc.data()['hours'] * doc.data()['minutes']) /
              productSnapshot.docs.length;
    });
    return totalhours.toDouble();
  }

  Future<double> totalratingratefunction() async {
    double totalrating = 0;
    QuerySnapshot<Map<String, dynamic>> productSnapshot =
        await FirebaseFirestore.instance
            .collection('timer')
            .where("username", isEqualTo: name)
            .get();
    productSnapshot.docs.forEach((doc) {
      totalrating = totalrating + double.parse((doc.data()['rating']));
    });
    return totalrating.toDouble() / productSnapshot.docs.length;
  }

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = selectedImage;
    });
  }

  void getUserUpdate() async {
    userCollection.doc(_auth.uid).snapshots().listen((event) {
      name = event.data()['name'];
      email = event.data()['email'];
      if (img == "") {
        img = null;
      }
      setState(() {});
    });
  }

  void initState() {
    getUserUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.all(18),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          name ?? '',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          email ?? '',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Data Information",
                          style: TextStyle(fontSize: 24),
                        ),
                        FutureBuilder<int>(
                            future: totalfunction(),
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.hasData) {
                                return ListTile(
                                    tileColor: Colors.blue,
                                    leading: Icon(Icons.bedtime),
                                    title: Text("My Sleep",
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                    trailing: Text(snapshot.data.toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                        )));
                              }
                              return CircularProgressIndicator();
                            }),
                        FutureBuilder<int>(
                            future: totalhoursfunction(),
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.hasData) {
                                return ListTile(
                                    tileColor: Colors.blue,
                                    leading: Icon(Icons.bedtime),
                                    title: Text("My Hours",
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                    trailing: Text(snapshot.data.toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                        )));
                              }
                              return CircularProgressIndicator();
                            }),
                        FutureBuilder<double>(
                            future: totalhoursratefunction(),
                            builder: (BuildContext context,
                                AsyncSnapshot<double> snapshot) {
                              if (snapshot.hasData) {
                                return ListTile(
                                    tileColor: Colors.blue,
                                    leading: Icon(Icons.bedtime),
                                    title: Text("My Rate Hours",
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                    trailing: Text(snapshot.data.toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                        )));
                              }
                              return CircularProgressIndicator();
                            }),
                        FutureBuilder<double>(
                            future: totalratingratefunction(),
                            builder: (BuildContext context,
                                AsyncSnapshot<double> snapshot) {
                              if (snapshot.hasData) {
                                return ListTile(
                                    tileColor: Colors.blue,
                                    leading: Icon(Icons.bedtime),
                                    title: Text("My Rate Ratings",
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                    trailing: Text(snapshot.data.toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                        )));
                              }
                              return CircularProgressIndicator();
                            }),
                        SingleChildScrollView(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('timer')
                                  .where("username", isEqualTo: name)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                } else {
                                  List<SleepTimerChart> sleeptimer = snapshot
                                      .data.docs
                                      .map((doc) =>
                                          SleepTimerChart.fromMap(doc.data()))
                                      .toList();
                                  return buildChart(context, sleeptimer);
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to sign out?"),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await AuthServices.signout().then((value) {
                                    if (value) {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return SignInPage();
                                      }));
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                },
                                child: Text("Yes"),
                              ),
                              TextButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: Text("Sign Out"),
                ),
              ),
            ],
          ),
        ),
        isLoading == true
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: SpinKitFadingCircle(
                  size: 50,
                  color: Colors.blue,
                ),
              )
            : Container()
      ]),
    );
  }

  Widget buildChart(BuildContext context, List<SleepTimerChart> sleeptimer) {
    mydata = sleeptimer;
    _generateData(mydata);
    return Container(
      height: 200,
      width: 200,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: charts.BarChart(
                _seriesBarData,
                animate: true,
                animationDuration: Duration(seconds: 2),
                domainAxis: new charts.OrdinalAxisSpec(
                    showAxisLine: true,
                    renderSpec: new charts.NoneRenderSpec()),
              ),
            ),
          ]),
    );
  }
}
