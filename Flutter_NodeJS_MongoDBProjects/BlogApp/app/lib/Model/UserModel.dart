class UserData {
  String img;
  String sId;
  String username;
  String password;
  String email;
  int iV;
  String bio;

  UserData(
      {this.img, this.sId, this.username, this.password, this.email, this.iV});

  UserData.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    sId = json['_id'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    iV = json['__v'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['__v'] = this.iV;
    data['bio'] = this.bio;
    return data;
  }
}
