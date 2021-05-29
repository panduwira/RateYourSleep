part of 'models.dart';

class RatingChart {
  final int rating;
  final String sleepdate;

  RatingChart(this.rating, this.sleepdate);

  RatingChart.fromMap(Map<String, dynamic>map)
  : assert(map['rating'] != null),
  assert(map['sleepdate'] != null),
  rating = map['rating'],
  sleepdate = map['sleepdate'];

  @override
  String toString() => "Record<$rating:$sleepdate>";
}