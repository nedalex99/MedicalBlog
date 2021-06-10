import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String email;
  String firstName;
  String lastName;
  String country;
  String profession;

  UserData({
    this.email,
    this.firstName,
    this.lastName,
    this.country,
    this.profession,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'country': country,
        'profession': profession,
      };

  factory UserData.fromJson(DocumentSnapshot parsedJson) {
    if (parsedJson.data() == null || parsedJson.data().isEmpty) {
      return UserData();
    }

    return UserData(
      email: parsedJson.data()['email'],
      firstName: parsedJson.data()['firstName'],
      lastName: parsedJson.data()['lastName'],
      country: parsedJson.data()['country]'],
      profession: parsedJson.data()['profession'],
    );
  }
}
