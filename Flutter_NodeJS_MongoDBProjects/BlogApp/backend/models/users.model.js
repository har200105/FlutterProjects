const mongoose = require("mongoose");

const User = mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  bio: String,
  img: {
    type: String,
    default: "https://res.cloudinary.com/harshit111/image/upload/v1627476210/cgggp1qrgbdp0usoahrf.png",
  },
});

module.exports = mongoose.model("User", User);
