part of 'services.dart';

class SleepTimerServices {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection("timer");
  static DocumentReference productDoc;

  static Reference ref;
  static UploadTask uploadTask;

  static Future<bool> addTimer(SleepTimer sleepTimer) async {
    await Firebase.initializeApp();
    
    productDoc = await productCollection.add({
      'id': "",
      'sleeptime': sleepTimer.sleeptime,
      'hours': sleepTimer.hours,
      'minutes': sleepTimer.minutes,
      'seconds': sleepTimer.seconds,
      'rating': sleepTimer.rating,
      'username': sleepTimer.username,
    });

    if (productDoc.id != null) {
      productCollection.doc(productDoc.id).update({
        'id': productDoc.id,
      });

      return true;
    } else {
      return false;
    }
  }

    static Future deleteProduct(String productID) async {

    await productCollection.doc(productID).delete();
    
  }
}
