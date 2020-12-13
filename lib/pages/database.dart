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
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Column(children: [Text('Date')]),
                  Column(children: [Text('Time')]),
                  Column(children: [Text('Rating')]),
                ]),
                TableRow(children: [
                  Column(children: [Text('1/1')]),
                  Column(children: [Text('04:20')]),
                  Column(children: [Text('3.5')]),
                ]),
                TableRow(children: [
                  Column(children: [Text('1/1')]),
                  Column(children: [Text('04:20')]),
                  Column(children: [Text('3.5')]),
                ]),
                TableRow(children: [
                  Column(children: [Text('1/1')]),
                  Column(children: [Text('04:20')]),
                  Column(children: [Text('3.5')]),
                ]),
              ],
            ),
          ])),
    );
  }
}
