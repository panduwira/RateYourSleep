part of 'pages.dart';

class MainMenu extends StatefulWidget {

  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  PageController pageController;
  static List<Widget> _widgetOptions = <Widget>[
    ListDataPage(),
    HomePage(),
    AccountPage(),
  ];

  @override
  void initState() {
    _widgetOptions.add(ListDataPage());
    _widgetOptions.add(HomePage());
    _widgetOptions.add(AccountPage());
    super.initState();
  }

  void _onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
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
                  color: Colors.lightBlue,
                ),
                label: 'Timer'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'My Account'),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          onTap: _onItemtapped,
          iconSize: 20,
        ),
      ),
    );
  }
}
