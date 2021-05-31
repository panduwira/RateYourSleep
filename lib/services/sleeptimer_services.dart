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
      'sleepdate': sleepTimer.sleepdate,
      'wakeupdate': sleepTimer.wakeupdate
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

  static Future<bool> editProduct(SleepTimer sleepTimer) async {
        await Firebase.initializeApp();

    await productCollection.doc(sleepTimer.id).update(
      {
        'rating': sleepTimer.rating
      },
    );

    return true;
  }

  static Future deleteProduct(String productID) async {
    await productCollection.doc(productID).delete();
  }
}
