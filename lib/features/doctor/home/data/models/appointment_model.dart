class AppointmentModel {
  String? docName;
  String? id;
  String? patientName;
  String? patientPhone;
  String? patientDesc;

  String? docId;
  String? patientId;
  String? docAddress;
  bool? isComplete;
  String? date;
  String? time;
  AppointmentModel({
    required this.patientPhone,
    required this.patientDesc,
    required this.isComplete,
    required this.patientId,
    required this.date,
    required this.docAddress,
    required this.id,
    required this.docId,
    required this.docName,
    required this.patientName,
    required this.time,
  });

  AppointmentModel.fromJson(json) {
    patientPhone = json["patient-phone"];
    patientDesc = json["patient-desc"];
    isComplete = json["is-complete"];
    patientId = json["patient-id"];
    date = json["date"];
    docAddress = json["doc-address"];
    docId = json["doc-id"];
    docName = json["doc-name"];
    patientName = json["patient-name"];
    time = json['time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'patient-id': patientId,
      'doc-id': docId,
      'patient-name': patientName,
      'patient-phone': patientPhone,
      'patient-desc': patientDesc,
      'doc-name': docName,
      'doc-address': docAddress,
      'date': date,
      'time': time,
      'is-complete': isComplete,
      'id': id,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      if (patientId != null) 'patient-id': patientId,
      if (docId != null) 'doc-id': docId,
      if (patientName != null) 'patient-name': patientName,
      if (patientPhone != null) 'patient-phone': patientPhone,
      if (patientDesc != null) 'patient-desc': patientDesc,
      if (docName != null) 'doc-name': docName,
      if (docAddress != null) 'doc-address': docAddress,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (isComplete != null) 'is-complete': isComplete,
      if (id != null) 'id': id,
    };
  }
}
