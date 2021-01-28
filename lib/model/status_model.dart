class StatusModel {
  String id_apply;
  String idResume;
  String idJobdescription;
  String idCategory;
  String status;

  StatusModel(
      {this.id_apply,
      this.idResume,
      this.idJobdescription,
      this.idCategory,
      this.status});

  StatusModel.fromJson(Map<String, dynamic> json) {
    id_apply = json['id_apply'];
    idResume = json['id_resume'];
    idJobdescription = json['id_jobdescription'];
    idCategory = json['id_category'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_apply'] = this.id_apply;
    data['id_resume'] = this.idResume;
    data['id_jobdescription'] = this.idJobdescription;
    data['id_category'] = this.idCategory;
    data['status'] = this.status;
    return data;
  }
}
