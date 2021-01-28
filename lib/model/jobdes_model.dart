class JobDesModel {
  String id_jobdescription;
  String idUser;
  String nameJob;
  String category;
  String description;
  String qualification;
  String age;
  String salary;
  String startTime;
  String endTime;
  String id_gender;
  String gender;
  String contact;
  String urlPicture;
  String lat;
  String lng;
  String id_category;
  String workday;
  String id_statusFav;

  JobDesModel({
    this.id_jobdescription,
    this.idUser,
    this.nameJob,
    this.id_category,
    this.category,
    this.description,
    this.qualification,
    this.age,
    this.salary,
    this.startTime,
    this.endTime,
    this.id_gender,
    this.gender,
    this.contact,
    this.urlPicture,
    this.lat,
    this.lng,
    this.workday,
    this.id_statusFav,
  });

  JobDesModel.fromJson(Map<String, dynamic> json) {
    id_jobdescription = json['id_jobdescription'];
    idUser = json['id_user'];
    nameJob = json['nameJob'];
    category = json['category'];
    id_category = json['id_category'];
    description = json['description'];
    qualification = json['qualification'];
    age = json['age'];
    salary = json['salary'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    id_gender = json['id_gender'];
    gender = json['gender'];
    contact = json['contact'];
    urlPicture = json['UrlPicture'];
    lat = json['Lat'];
    lng = json['Lng'];
    workday = json['workday'];
    id_statusFav = json['id_statusFav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jobdescription'] = this.id_jobdescription;
    data['id_user'] = this.idUser;
    data['nameJob'] = this.nameJob;
    data['category'] = this.category;
    data['id_category'] = this.id_category;
    data['description'] = this.description;
    data['qualification'] = this.qualification;
    data['age'] = this.age;
    data['salary'] = this.salary;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['id_gender'] = this.id_gender;
    data['gender'] = this.gender;
    data['contact'] = this.contact;
    data['UrlPicture'] = this.urlPicture;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['workday'] = this.workday;
    data['id_statusFav'] = this.id_statusFav;

    return data;
  }
}
