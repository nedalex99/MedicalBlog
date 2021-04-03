class UserData {
  String email;
  String firstName;
  String lastName;
  String country;

  UserData({this.email, this.firstName, this.lastName, this.country});

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'country': country
      };
}
