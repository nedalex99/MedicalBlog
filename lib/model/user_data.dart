import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  String email;
  String firstName;
  String lastName;
  String country;
  String profession;
  String specialty;
  int yearsOfExperience;
  String dateOfBirth;

  UserData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.country,
    this.profession,
    this.specialty,
    this.yearsOfExperience,
    this.dateOfBirth,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'country': country,
        'profession': profession,
        'specialty': specialty,
        'yearsOfExperience': yearsOfExperience,
        'dateOfBirth': dateOfBirth,
      };

  factory UserData.fromJson(DocumentSnapshot parsedJson) {
    if (parsedJson.data() == null || (parsedJson.data() as Map).isEmpty) {
      return UserData();
    }

    return UserData(
      id: parsedJson.id,
      email: (parsedJson.data() as Map)['email'],
      firstName: (parsedJson.data() as Map)['firstName'],
      lastName: (parsedJson.data() as Map)['lastName'],
      country: (parsedJson.data() as Map)['country'],
      profession: (parsedJson.data() as Map)['profession'],
      specialty: (parsedJson.data() as Map)['specialty'],
      yearsOfExperience: (parsedJson.data() as Map)['yearsOfExperience'],
    );
  }
}
