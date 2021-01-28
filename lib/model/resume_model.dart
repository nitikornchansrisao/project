class ResumeModel {
  String id;
  String idUser;
  String firstname;
  String lastname;
  String age;
  String gender;
  String experience;
  String address;
  String contact;
  String urlPicture;
  // String status;


  ResumeModel(
      {this.id,
      this.idUser,
      this.firstname,
      this.lastname,
      this.age,
      this.gender,
      this.experience,
      this.address,
      this.contact,
      this.urlPicture,
      // this.status,
      });

  ResumeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    gender = json['gender'];
    experience = json['experience'];
    address = json['address'];
    contact = json['contact'];
    urlPicture = json['urlPicture'];
    // status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['experience'] = this.experience;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['urlPicture'] = this.urlPicture;
    // data['status'] = this.status;

    return data;
  }
}
