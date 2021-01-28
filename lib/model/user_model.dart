class UserModel {
  String id;
  String name;
  String username;
  String password;
  String choosetype;

  UserModel(
      {this.id, this.name, this.username, this.password, this.choosetype});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    choosetype = json['choosetype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['choosetype'] = this.choosetype;
    return data;
  }
}
