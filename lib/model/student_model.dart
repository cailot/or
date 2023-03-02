class StudentModel {
  late int? id;

  late String? firstName,
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

  StudentModel({
    this.id,
    this.firstName,
    this.lastName,
    this.grade,
    this.contactNo1,
    this.contactNo2,
    this.email,
    this.address,
    this.state,
    this.branch,
    this.memo,
    this.registerDate,
    this.enrolmentDate,
    this.endDate
  });

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

  @override
  String toString(){
    return 'id=$id, firstName=$firstName, lastName=$lastName, grade=$grade, contactNo1=$contactNo1, contactNo2=$contactNo2, email=$email, address=$address, state=$state, branch=$branch, memo=$memo, registerDate=$registerDate, enrolmentDate=$enrolmentDate, endDate=$endDate';
  }

}
