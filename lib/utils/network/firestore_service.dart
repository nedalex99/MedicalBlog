import 'package:medical_blog/logic/model/user_data.dart';

class FirestoreService {
  static Future<FirestoreService> get _instance async =>
      _firestoreService ??= FirestoreService();
  static FirestoreService _firestoreService;

  static Future<FirestoreService> init() async {
    if (_firestoreService == null) _firestoreService = await _instance;
    return _firestoreService;
  }

  // FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  //
  // Future<void> createUser(
  //     {String uid,
  //     String email,
  //     String firstName,
  //     String lastName,
  //     String country}) {
  //   Map<String, UserData> user = {
  //     'user': UserData(
  //         email: email,
  //         firstName: firstName,
  //         lastName: lastName,
  //         country: country)
  //   };
  //
  //   return _firestoreInstance.collection('users').doc(uid).set(user);
  // }
}
