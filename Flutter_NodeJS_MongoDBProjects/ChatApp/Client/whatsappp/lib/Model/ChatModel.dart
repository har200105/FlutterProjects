class Chat {
  Chat({
    required this.data,
  });
  late final List<Data> data;
  
  Chat.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.chatName,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String id;
  late final String chatName;
  late final List<Users> users;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    chatName = json['chatName'];
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['chatName'] = chatName;
    _data['users'] = users.map((e)=>e.toJson()).toList();
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class Users {
  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.pic,
    required this.V,
  });
  late final String id;
  late final String name;
  late final String email;
  late final String pic;
  late final int V;
  
  Users.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    pic = json['pic'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['pic'] = pic;
    _data['__v'] = V;
    return _data;
  }
}