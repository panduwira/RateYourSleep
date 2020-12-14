part of 'pages.dart';

class DatabasePage extends StatefulWidget {
  DatabasePage({Key key}) : super(key: key);

  @override
  _DatabasePageState createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep Data"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(children: <Widget>[
            Text(
              "All Data",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(width: 3, color: Colors.black),
              children: [
                TableRow(children: [
                  Column(children: [Text('Date', style: TextStyle(fontSize: 20),)]),
                  Column(children: [Text('Time', style: TextStyle(fontSize: 20),)]),
                  Column(children: [Text('Rating', style: TextStyle(fontSize: 20),)]),
                ]),
                TableRow(children: [
                  Column(children: [Text('1/1', style: TextStyle(fontSize: 16),)]),
                  Column(children: [Text('04:20', style: TextStyle(fontSize: 16),)]),
                  Column(children: [Text('3.5', style: TextStyle(fontSize: 16),)]),
                ]),
                TableRow(children: [
                  Column(children: [Text('1/1', style: TextStyle(fontSize: 16),)]),
                  Column(children: [Text('04:20', style: TextStyle(fontSize: 16),)]),
                  Column(children: [Text('3.5', style: TextStyle(fontSize: 16),)]),
                ]),
                TableRow(children: [
                  Column(children: [Text('1/1', style: TextStyle(fontSize: 16),)]),
                  Column(children: [Text('04:20', style: TextStyle(fontSize: 16),)]),
                  Column(children: [Text('3.5', style: TextStyle(fontSize: 16),)]),
                ]),
              ],
            ),
          ])),
    );
  }
}
