import 'package:flutter/semantics.dart';
import 'package:rateyoursleep/models/models.dart';
import 'package:rateyoursleep/services/services.dart';
import 'package:rateyoursleep/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TimeDataCard extends StatelessWidget {
  final SleepTimer sleeptimer;
  const TimeDataCard({this.sleeptimer});

  @override 
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(8),
      child: ListTile(
        onTap: () async {
           await showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: Text("My Sleep Data"),
                    content: Text("Wanna changes on " + sleeptimer.sleepdate),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            bool result =
                                await SleepTimerServices.deleteProduct(sleeptimer.id);
                            if (result == true) {
                              Fluttertoast.showToast(
                                  msg: "Success :-)",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER_RIGHT,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.yellow,
                                  fontSize: 16.0);
                            }
                          },
                          child: Text('Delete')),
                    ],
                  ));
        },

        title: Text(sleeptimer.rating),
        subtitle: Text(sleeptimer.sleeptime),
        leading: Icon(Icons.star),
        
      ),
    );
  }
}