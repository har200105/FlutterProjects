const express = require("express");
const User = require("../models/users.model");
const config = require("../config");
const jwt = require("jsonwebtoken");
let middleware = require("../middleware/middleware");
const router = express.Router();

router.route("/getuser/:id").get(middleware, (req, res) => {
  console.log("dwfef")
  User.findById(req.params.id, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.status(201).json(result);
  });
});

router.route("/checkUsername/:username").get((req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result !== null) {
      return res.json({
        Status: true,
      });
    } else
      return res.status(201).json({
        Status: false,
      });
  });
});

router.route("/login").post((req, res) => {
  User.findOne({ username: req.body.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result === null) {
      return res.status(403).json("Username incorrect");
    }
    if (result.password === req.body.password) {
      let token = jwt.sign({ _id: result._id }, config.key, {});

      res.status(201).json({
        token: token,
        id:result._id,
        msg: "success",
      });
    } else {
      res.status(403).json("password is incorrect");
    }
  });
});

router.route("/register").post((req, res) => {
  console.log("inside the register");
  const user = new User({
    username: req.body.username,
    password: req.body.password,
    email: req.body.email,
  });
  user
    .save()
    .then(() => {
      console.log("user registered");
      res.status(200).json({ msg: "User Successfully Registered" });
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});

router.route("/update").post(middleware,(req, res) => {
  console.log(req.user._id);
  User.findByIdAndUpdate(req.user._id,
    { $set: req.body },
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "Profile successfully Updated",
        id: req.user._id,
      };
      return res.status(201).json(msg);
    }
  );
});

router.route("/delete/:username").delete(middleware, (req, res) => {
  User.findOneAndDelete({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    const msg = {
      msg: "User deleted",
      username: req.params.username,
    };
    return res.status(201).json(msg);
  });
});


router.route("/checkProfile").get(middleware, (req, res) => {
  console.log(req.user._id);
  return res.status(201).json( req.user );
});

module.exports = router;
