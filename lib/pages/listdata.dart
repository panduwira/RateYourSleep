part of 'pages.dart';

class ListDataPage extends StatefulWidget {
  ListDataPage({Key key}) : super(key: key);

  @override
  _ListDataPageState createState() => _ListDataPageState();
}

class _ListDataPageState extends State<ListDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep Average"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(children: <Widget>[
            SizedBox(
              width: 318,
              height: 71,
              child: Text(
                "Average Sleep Time",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 156,
                  height: 40,
                  child: Text(
                    "Last 7 days",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 44,
                  height: 40,
                  child: Text(
                    "0.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: Text(
                    "hours",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 156,
                height: 40,
                child: Text(
                  "Last 30 days",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                width: 44,
                height: 40,
                child: Text(
                  "0.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: Text(
                  "hours",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 156,
                height: 40,
                child: Text(
                  "All Time",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                width: 44,
                height: 40,
                child: Text(
                  "0.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: Text(
                  "hours",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ]),
            SizedBox(
              width: 318,
              height: 71,
              child: Text(
                "Average Rating",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 156,
                  height: 40,
                  child: Text(
                    "Last 7 days",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 44,
                  height: 40,
                  child: Text(
                    "0.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                
                
                
                
                SizedBox(
                  width: 30,
                  height: 40,
                  child: Text(
                    "/ 5",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                
                
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 156,
                  height: 40,
                  child: Text(
                    "Last 30 days",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 44,
                  height: 40,
                  child: Text(
                    "0.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 40,
                  child: Text(
                    "/ 5",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 156,
                  height: 40,
                  child: Text(
                    "All time",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 44,
                  height: 40,
                  child: Text(
                    "0.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 40,
                  child: Text(
                    "/ 5",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                )
              ],
            ),
            RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.chat_bubble), label: Text("Show Data"))
          ])),
    );
  }
}
