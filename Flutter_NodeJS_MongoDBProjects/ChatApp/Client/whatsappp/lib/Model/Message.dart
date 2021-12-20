class MessageModel {
  List<Messages>? messages;

  MessageModel({this.messages});

  MessageModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? sId;
  Sender? sender;
  String? content;
  Chat? chat;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Messages(
      {this.sId,
      this.sender,
      this.content,
      this.chat,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Messages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    content = json['content'];
    chat = json['chat'] != null ? new Chat.fromJson(json['chat']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    data['content'] = this.content;
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Sender {
  String? sId;
  String? name;
  String? email;

  Sender({this.sId, this.name, this.email});

  Sender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class Chat {
  String? sId;
  String? chatName;
  List<String>? users;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Chat(
      {this.sId,
      this.chatName,
      this.users,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Chat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatName = json['chatName'];
    users = json['users'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['chatName'] = this.chatName;
    data['users'] = this.users;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}