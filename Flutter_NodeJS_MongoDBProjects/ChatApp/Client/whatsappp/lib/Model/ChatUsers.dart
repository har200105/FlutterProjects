class ChatUsers {
  List<ChatUser> ? user;

  ChatUsers({this.user});

  ChatUsers.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <ChatUser>[];
      json['user'].forEach((v) {
        user!.add(new ChatUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null){
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatUser {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? pic;
  int? iV;

  ChatUser({this.sId, this.name, this.email, this.password, this.pic, this.iV});

  ChatUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    pic = json['pic'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['pic'] = this.pic;
    data['__v'] = this.iV;
    return data;
  }
}