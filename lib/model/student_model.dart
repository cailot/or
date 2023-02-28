class StudentModel {
  late int id;

  late String firstName,
      lastName,
      grade,
      contactNo1,
      contactNo2,
      email,
      address,
      state,
      branch,
      memo,
      registerDate,
      enrolmentDate,
      endDate;

  StudentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        grade = json['grade'],
        contactNo1 = json['contactNo1'],
        contactNo2 = json['contactNo2'],
        email = json['email'],
        address = json['address'],
        state = json['state'],
        branch = json['branch'],
        memo = json['memo'],
        registerDate = json['registerDate'],
        enrolmentDate = json['enrolmentDate'],
        endDate = json['endDate'];
}
