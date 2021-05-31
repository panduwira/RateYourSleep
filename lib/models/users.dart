part of 'models.dart';

class Users extends Equatable{

  final String uid;
  final String email;
  final String name;
  final String profilePicture;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Users(this.uid, this.email, {this.name, this.profilePicture});

  @override
  List<Object> get props => [uid, email, name, profilePicture];

    static Future<void> updateUser(Users users) async {
    userCollection.doc(users.uid).set({
      'uid': users.uid,
      'email': users.email,
      'name': users.name,
      'profilePicture': users.profilePicture ?? ""
    });
  }

    static Future<bool> editUser(Users users) async {
    //await Firebase.initializeApp();

    await userCollection.doc(users.uid).update(
      {
        'name': users.name,
      },
    );

    return true;
  }
}