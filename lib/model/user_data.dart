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
        'country': country
      };

  factory UserData.fromJson(Map<dynamic, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson.isEmpty) {
      return UserData();
    }

    return UserData(
      email: parsedJson['email'],
      firstName: parsedJson['firstName'],
      lastName: parsedJson['lastName'],
      country: parsedJson['country]'],
      profession: parsedJson['profession'],
    );
  }
}