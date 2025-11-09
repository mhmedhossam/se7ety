class DoctorModel {
  String? title;
  String? subTitle;
  String? image;
  int? rate;

  DoctorModel({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.rate,
  });

  DoctorModel.fromJson(json) {
    image = json["image"];
    subTitle = json["specialization"];
    title = json["name"];
    rate = json["rating"];
  }
}
