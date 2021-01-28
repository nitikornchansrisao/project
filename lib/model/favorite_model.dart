class FavoriteModel {
  String id_favorite;
  String idResume;
  String idJobdescription;
  String idCategory;
  String status;

  FavoriteModel(
      {this.id_favorite,
      this.idResume,
      this.idJobdescription,
      this.idCategory,
      this.status});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id_favorite = json['id_favorite'];
    idResume = json['id_resume'];
    idJobdescription = json['id_jobdescription'];
    idCategory = json['id_category'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_favorite'] = this.id_favorite;
    data['id_resume'] = this.idResume;
    data['id_jobdescription'] = this.idJobdescription;
    data['id_category'] = this.idCategory;
    data['status'] = this.status;
    return data;
  }
}
