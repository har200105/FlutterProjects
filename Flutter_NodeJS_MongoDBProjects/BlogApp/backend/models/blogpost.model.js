const mongoose = require("mongoose");

const BlogPost = mongoose.Schema({
  postedBy: {
    type:mongoose.Schema.Types.ObjectId,
    ref:"User"
  },
  title: String,
  body: String,
  postImage: {
    type: String,
    default: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
  },
  like: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  }],
  comments: [{
    Comment: String,
    commentedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref:"User"
    },
}],

});

module.exports = mongoose.model("BlogPost", BlogPost);
