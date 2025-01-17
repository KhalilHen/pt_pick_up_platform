

class User {

  final String uid;
  final String? email;
  final int?  phoneNumber;



  User({
    required this.uid,
    required this.email,
    required this.phoneNumber,
  });


  factory User.fromMap(Map<String, dynamic> data) {

    return User(uid: 
   data['id'],
   email: data['email'], 
   phoneNumber: data['phone_number']);

  }
}