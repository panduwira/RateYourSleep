part of 'pages.dart';

class DatabasePage extends StatefulWidget {
  DatabasePage({Key key}) : super(key: key);

  @override
  _DatabasePageState createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  CollectionReference timercollection = FirebaseFirestore.instance.collection('timer');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep Data"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(
          children: [
            Container(
            width: double.infinity,
            height: double.infinity,
            child:
            StreamBuilder<QuerySnapshot>(
                stream: timercollection.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  final documents = snapshot.data.docs;
                  final sum =
                      documents.fold(0, (s, n) => s + int.parse(n['Value']));
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        final documentSnapshot = snapshot.data.docs[index];
                        final value = int.parse(documentSnapshot['hours']);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Document : $sum'),
                        );
                      });
                }),
          )
          ])
          );
          
    
  }
}
