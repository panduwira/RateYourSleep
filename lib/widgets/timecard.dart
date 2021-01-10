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
      margin: EdgeInsets.all(6),
      child: ListTile(
        onTap: () async {

        },

        title: Text(sleeptimer.rating),
        subtitle: Text(sleeptimer.sleeptime),
        leading: Container()
      ),
    );
  }
}