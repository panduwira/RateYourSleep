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
        title: Text("All Average"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: productCollection.where('username', isEqualTo : name).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Failed to get products data!");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitFadingCircle(
                    size: 50,
                    color: Colors.blue,
                  );
                }

                return ListView(
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
            )),
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
