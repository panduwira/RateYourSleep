import 'package:rateyoursleep/models/models.dart';
import 'package:rateyoursleep/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TimeDataCard extends StatelessWidget {
  final SleepTimer sleeptimer;
  const TimeDataCard({this.sleeptimer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      shadowColor: Theme.of(context).cardTheme.shadowColor,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: ListTile(
          isThreeLine: true,
          onTap: () async {
            await showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                      title: Text(sleeptimer.sleepdate),
                      content: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                child: ListTile(
                              title: Text('Start Time '),
                              trailing: Text(sleeptimer.sleepdate),
                            )),
                            Container(
                                child: ListTile(
                              title: Text('End Time '),
                              trailing: Text(sleeptimer.wakeupdate),
                            )),
                            Container(
                              child: ListTile(
                              title: Text('Length '),
                              trailing: Text(sleeptimer.hours.toString() +
                                  ":" +
                                  sleeptimer.minutes.toString() +
                                  ":" +
                                  sleeptimer.seconds.toString()),
                            )),
                            Container(
                              child: ListTile(
                              title: Text('Rating '),
                              trailing: Text(sleeptimer.rating),
                            )),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              bool result =
                                  await SleepTimerServices.deleteProduct(
                                      sleeptimer.id);
                              if (result == true) {
                                Fluttertoast.showToast(
                                    msg: "Data deleted",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER_RIGHT,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.yellow,
                                    fontSize: 16.0);
                              }
                            },
                            child: Text('Delete', style: TextStyle(color: Colors.redAccent),)),
                      ],
                    ));
          },
          title: Text(sleeptimer.sleeptime, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          subtitle: Text(sleeptimer.rating, style: TextStyle(fontSize: 20),),
          leading: Icon(
            Icons.star,
            color: Colors.amber,
            size: 32,
          ),
          trailing: Text(sleeptimer.sleepdate + "\n\n" + sleeptimer.wakeupdate),
        ),
      ),
    );
  }
}
