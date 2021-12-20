class BlogModel {
  List<Data> data;

  BlogModel({this.data});

  BlogModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String postImage;
  List<Like> like;
  String sId;
  Like postedBy;
  String title;
  String body;
  List<Comments> comments;
  int iV;

  Data(
      {this.postImage,
      this.like,
      this.sId,
      this.postedBy,
      this.title,
      this.body,
      this.comments,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    postImage = json['postImage'];
    if (json['like'] != null) {
      like = new List<Like>();
      json['like'].forEach((v) {
        like.add(new Like.fromJson(v));
      });
    }
    sId = json['_id'];
    postedBy =
        json['postedBy'] != null ? new Like.fromJson(json['postedBy']) : null;
    title = json['title'];
    body = json['body'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postImage'] = this.postImage;
    if (this.like != null) {
      data['like'] = this.like.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    if (this.postedBy != null) {
      data['postedBy'] = this.postedBy.toJson();
    }
    data['title'] = this.title;
    data['body'] = this.body;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Like {
  String img;
  String sId;
  String username;
  String email;

  Like({this.img, this.sId, this.username, this.email});

  Like.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}

class Comments {
  String sId;
  String comment;
  Like commentedBy;

  Comments({this.sId, this.comment, this.commentedBy});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    comment = json['Comment'];
    commentedBy = json['commentedBy'] != null
        ? new Like.fromJson(json['commentedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Comment'] = this.comment;
    if (this.commentedBy != null) {
      data['commentedBy'] = this.commentedBy.toJson();
    }
    return data;
  }
}
