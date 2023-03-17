class StudentModel {
  int? id;

  String? firstName,
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

  StudentModel(
      {this.id,
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
      this.endDate});

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['grade'] = grade;
    data['contactNo1'] = contactNo1;
    data['contactNo2'] = contactNo2;
    data['email'] = email;
    data['address'] = address;
    data['state'] = state;
    data['branch'] = branch;
    data['memo'] = memo;
    data['enrolmentDate'] = enrolmentDate;
    return data;
  }

  @override
  String toString() {
    return '[StudentModel : toString] id=$id, firstName=$firstName, lastName=$lastName, grade=$grade, contactNo1=$contactNo1, contactNo2=$contactNo2, email=$email, address=$address, state=$state, branch=$branch, memo=$memo, registerDate=$registerDate, enrolmentDate=$enrolmentDate, endDate=$endDate';
  }

  void reset() {
    id = null;
    firstName = null;
    lastName = null;
    grade = null;
    contactNo1 = null;
    contactNo2 = null;
    email = null;
    address = null;
    state = null;
    branch = null;
    memo = null;
    registerDate = null;
    enrolmentDate = null;
    endDate = null;
  }
}
