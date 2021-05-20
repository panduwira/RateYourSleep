part of 'pages.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  bool isLoading = false;
  String pagetitle;
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");
  User _auth = FirebaseAuth.instance.currentUser;

  String img, name, email;

  PageController pageController;
  static List<Widget> _widgetOptions = <Widget>[
    ListDataPage(),
    HomePage(),
    AccountPage(),
  ];

  void getUserUpdate() async {
    userCollection.doc(_auth.uid).snapshots().listen((event) {
      name = event.data()['name'];
      email = event.data()['email'];
      setState(() {});
    });
  }

  @override
  void initState() {
    _widgetOptions.add(ListDataPage());
    _widgetOptions.add(HomePage());
    _widgetOptions.add(AccountPage());
    pagetitle = "RateYourSleep";
    getUserUpdate();
    super.initState();
  }

  void _onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            pagetitle = 'My Data';
          }
          break;
        case 1:
          {
            pagetitle = 'Sleep Timer';
          }
          break;
        case 2:
          {
            pagetitle = 'My Account';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pagetitle),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
          child: Text(name ?? ''),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        ListTile(
          title: Text("Change Theme"),
          leading: Icon(Icons.format_paint),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => ThemeDialog(
                      animatedOpacityDuration: 1,
                    ));
          },
        ),
        ListTile(
          title: Text("Settings"),
          leading: Icon(Icons.settings),
          onTap: () {
          },
        ),
        ListTile(
          title: Text("About Application"),
          leading: Icon(Icons.info),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                new AlertDialog (
                  title: Text("Rate Your Sleep"),
                  content: Container(
                    
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          leading: Text("App Version"),
                          trailing: Text("1.0.1"),
                      )]
                    ),
                  )
                );
              }
            );
          },
        ),
        ListTile(
          title: Text("Log Out"),
          leading: Icon(Icons.logout),
          onTap: () {
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
                : Container();
          },
        ),
        
      ])),
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.single_bed_sharp), label: 'My Data'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.timer,
                  size: 24,
                ),
                label: 'Timer'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'My Account'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemtapped,
          iconSize: 20,
        ),
      ),
    );
  }
}

class MyThemeOptions implements AppThemeOptions {
  final Color specificButtonColor;
  MyThemeOptions(this.specificButtonColor);
}


