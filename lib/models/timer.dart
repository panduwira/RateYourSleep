part of 'models.dart';


class Timer extends Equatable{
  final String id;
  final String sleeptime;
  final int hours;
  final int minutes;
  final int seconds;
  final int rating;

  Timer(this.id,this.sleeptime,this.hours,this.minutes,this.seconds,this.rating);

  @override
  // TODO: implement props
  List<Object> get props => [id, sleeptime, hours, minutes, seconds, rating];
 
}
