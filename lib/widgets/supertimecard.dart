import 'package:rateyoursleep/models/models.dart';
import 'package:rateyoursleep/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuperTimeDataCard extends StatelessWidget {
  final SleepTimer sleeptimer;
  const SuperTimeDataCard({this.sleeptimer});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        isThreeLine: true,
        onTap: () async {
          await showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: Text("Last Session : " + 
                      sleeptimer.sleepdate),
                    content: Text("Start time: " +
                        sleeptimer.sleepdate +
                        "\n End time: " +
                        sleeptimer.wakeupdate +
                        "\n Length: " +
                        sleeptimer.hours.toString() +
                        ":" +
                        sleeptimer.minutes.toString() +
                        ":" +
                        sleeptimer.seconds.toString() +
                        "\n\n Rating: " +
                        sleeptimer.rating),
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
                          child: Text('Delete')),
                    ],
                  ));
        },
        title: Text(sleeptimer.rating, style: TextStyle(fontSize: 32),),
        subtitle: Text(sleeptimer.sleeptime + "\n" + sleeptimer.sleepdate),
        leading: Icon(
          Icons.star,
          color: Colors.amber,
          size: 36,
        ),
      ),
    );
  }
}
