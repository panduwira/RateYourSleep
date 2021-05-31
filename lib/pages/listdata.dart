part of 'pages.dart';

class ListDataPage extends StatefulWidget {
  ListDataPage({Key key}) : super(key: key);

  @override
  _ListDataPageState createState() => _ListDataPageState();
}

class _ListDataPageState extends State<ListDataPage> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
  static String name;
  bool isLoading = false;
  User _auth = FirebaseAuth.instance.currentUser;
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");
  CollectionReference<Map<String, dynamic>> productCollection =
      FirebaseFirestore.instance.collection("timer");
  Query<Map<String, dynamic>> productquery = FirebaseFirestore.instance.collection("timer");
  //UserServices.userCollection.where("name", isEqualTo: name.toString()));
  //productCollection.where("user", isEqualTo: "unapproved");

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

  Widget portaitMode(){
    return Stack(
      alignment: Alignment.topLeft,
      fit: StackFit.expand,
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: double.infinity,
            child: Column(children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                "Latest Data",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
                
              )),
              SizedBox(
                height: 16,
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: productquery.orderBy('sleepdate', descending: true)
                      .where('username', isEqualTo: name)
                    .limit(1)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Failed to get sleep data");
                  }

                  if (snapshot.hasData == false) {
                    return Text("Oh No!");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
                      return SuperTimeDataCard(
                        sleeptimer: SleepTimer(
                          doc.data()['id'],
                          doc.data()['sleeptime'],
                          doc.data()['hours'],
                          doc.data()['minutes'],
                          doc.data()['seconds'],
                          doc.data()['rating'],
                          doc.data()['username'],
                          doc.data()['sleepdate'],
                          doc.data()['wakeupdate'],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                "All Data",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
                
              )),
              SizedBox(
                height: 16,
              ),
              Flexible(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: productquery
                      .where('username', isEqualTo: name).orderBy('sleepdate', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Failed to get sleep data");
                    }

                    if (snapshot.hasData == false) {
                    return Text("Oh No!");
                  }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitFadingCircle(
                        size: 50,
                        color: Colors.blue,
                      );
                    }

                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
                        return TimeDataCard(
                          sleeptimer: SleepTimer(
                            doc.data()['id'],
                            doc.data()['sleeptime'],
                            doc.data()['hours'],
                            doc.data()['minutes'],
                            doc.data()['seconds'],
                            doc.data()['rating'],
                            doc.data()['username'],
                            doc.data()['sleepdate'],
                            doc.data()['wakeupdate'],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ])),
        isLoading == true
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: SpinKitCircle(size: 50, color: Colors.blue))
            : Container()
      ]
    );

  }

  Widget landscapeMode(){
        return Stack(
      alignment: Alignment.topLeft,
      fit: StackFit.expand,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: double.infinity,
            child: Column(children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                "Latest Data",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
                
              )
              ),          
              SizedBox(
                height: 16,
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: productquery.orderBy('sleepdate', descending: true)
                      .where('username', isEqualTo: name)
                    .limit(1)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Failed to get sleep data");
                  }

                  if (snapshot.hasData == false) {
                    return Text("Oh No!");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
                      return SuperTimeDataCard(
                        sleeptimer: SleepTimer(
                          doc.data()['id'],
                          doc.data()['sleeptime'],
                          doc.data()['hours'],
                          doc.data()['minutes'],
                          doc.data()['seconds'],
                          doc.data()['rating'],
                          doc.data()['username'],
                          doc.data()['sleepdate'],
                          doc.data()['wakeupdate'],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                "All Data",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18)       
              )
              ),
              SizedBox(
                height: 16,
              ),
              Flexible(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: productquery
                      .where('username', isEqualTo: name).orderBy('sleepdate', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Failed to get sleep data");
                    }

                    if (snapshot.hasData == false) {
                    return Text("Oh No!");
                  }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitFadingCircle(
                        size: 50,
                        color: Colors.blue,
                      );
                    }

                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
                        return TimeDataCard(
                          sleeptimer: SleepTimer(
                            doc.data()['id'],
                            doc.data()['sleeptime'],
                            doc.data()['hours'],
                            doc.data()['minutes'],
                            doc.data()['seconds'],
                            doc.data()['rating'],
                            doc.data()['username'],
                            doc.data()['sleepdate'],
                            doc.data()['wakeupdate'],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ])),
        isLoading == true
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: SpinKitCircle(size: 50, color: Colors.blue))
            : Container()
      ]
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation){
        if(orientation == Orientation.portrait){
          return portaitMode();
        } else {
          return landscapeMode();
        }
      })
    );
  }
}
