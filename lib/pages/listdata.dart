part of 'pages.dart';

class ListDataPage extends StatefulWidget {
  ListDataPage({Key key}) : super(key: key);

  @override
  _ListDataPageState createState() => _ListDataPageState();
}

class _ListDataPageState extends State<ListDataPage> {
  static String name;
  bool isLoading = false;
  User _auth = FirebaseAuth.instance.currentUser;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection("timer");
  //final int prodcount =
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Sleep Data"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(alignment: Alignment.topLeft, children: <Widget>[
        Container(
            padding: EdgeInsets.only(bottom: 20),
            width: double.infinity,
            height: double.infinity,
            child: Column(children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Text(
                "Latest Data",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: productCollection
                    .where('username', isEqualTo: name)
                    .limit(1)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Failed to get sleep data");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data.docs.map((DocumentSnapshot doc) {
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
                height: 8,
              ),
              Text(
                "All Data",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: productCollection
                    .where('username', isEqualTo: name)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Failed to get sleep data");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data.docs.map((DocumentSnapshot doc) {
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
            ])),
        isLoading == true
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: SpinKitCircle(size: 50, color: Colors.blue))
            : Container()
      ]),
    );
  }
}
