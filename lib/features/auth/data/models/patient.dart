class Patient {
  String? name;
  String? email;
  String? uid;
  String? imageUrl;
  String? phone;
  String? age;
  int? gender;
  String? bio;
  String? city;

  Patient({
    this.name,
    this.email,
    this.uid,
    this.imageUrl,
    this.phone,
    this.age,
    this.bio,
    this.city,
    this.gender,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    imageUrl = json['image'];
    bio = json['bio'];
    city = json['city'];
    gender = json['gender'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'image': imageUrl,
      'bio': bio,
      'city': city,
      'gender': gender,
      'age': age,
    };
  }

  Map<String, dynamic> toJsonUpdateData() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (imageUrl != null) data['image'] = imageUrl;
    if (bio != null) data['bio'] = bio;
    if (city != null) data['city'] = city;
    if (gender != null) data['gender'] = gender;
    if (age != null) data['age'] = age;
    return data;
  }
}
