part of 'models.dart';


class SleepTimer extends Equatable{
  final String id;
  final String sleeptime;
  final int hours;
  final int minutes;
  final int seconds;
  final String rating;
  final String username;
  final String sleepdate;
  final String wakeupdate;
  //final Timestamp starttimestamp;
  //final Timestamp stoptimestamp;

  SleepTimer(this.id,this.sleeptime,this.hours,this.minutes,this.seconds,this.rating, this.username, this.sleepdate, this.wakeupdate);

  @override
  List<Object> get props => [id, sleeptime, hours, minutes, seconds, rating, username, sleepdate, wakeupdate];
 
}
