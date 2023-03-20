class ListConditionModel {
  String? state, branch, grade, year, activeStudent;

  ListConditionModel(
      {this.state, this.branch, this.grade, this.year, this.activeStudent});

  ListConditionModel.fromJson(Map<String, dynamic> json)
      : state = json['state'],
        branch = json['branch'],
        grade = json['grade'],
        year = json['year'],
        activeStudent = json['activeStudent'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['branch'] = branch;
    data['grade'] = grade;
    data['year'] = year;
    data['activeStudent'] = activeStudent;
    return data;
  }

  @override
  String toString() {
    return '[StudentModel : toString] state=$state, branch=$branch, grade=$grade, year=$year, activeStudent=$activeStudent';
  }

  void reset() {
    state = null;
    branch = null;
    grade = null;
    year = null;
    activeStudent = null;
  }
}
