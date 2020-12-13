part of 'pages.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);
  

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
    int _selectedIndex = 0;
    static List<Widget> _widgetOptions = <Widget>[HomePage(),ListDataPage()];

  void _onItemtapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: _widgetOptions.elementAt(_selectedIndex),
       ),
       bottomNavigationBar:BottomNavigationBar( 
        items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
             icon: Icon(Icons.home),
             label: 'Home'),
           BottomNavigationBarItem(
             icon: Icon(Icons.single_bed_sharp),
             label: 'Sleep Data'),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        onTap: _onItemtapped,
          ),
    );
  }
}