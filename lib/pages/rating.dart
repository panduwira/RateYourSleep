part of 'pages.dart';

//Rating ga jalan
class RatingMenu extends StatefulWidget {
  @override
  _RatingMenuState createState() => _RatingMenuState();
}

class _RatingMenuState extends State<RatingMenu> {
  double _rating;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'How was Your Sleep?',
              style: TextStyle(fontSize: 30.0),
            ),
            Text('Please Rate Your Sleep'),
            RatingBar.builder(
              itemCount: 5,
              initialRating: 3,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            _rating != null
                ? Text(
                    'Rating: $_rating',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
