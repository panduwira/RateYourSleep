part of 'models.dart';

class SleepTimerChart {
  final int hours;
  final String sleepdate;

  SleepTimerChart(this.hours, this.sleepdate);

  SleepTimerChart.fromMap(Map<String, dynamic> map)
  : assert(map['hours'] != null),
    assert(map['sleepdate'] != null),
    hours = map['hours'],
    sleepdate = map['sleepdate'];
  
  @override
  String toString() => "Record<$hours:$sleepdate>";
  
}