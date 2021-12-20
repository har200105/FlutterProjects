const express = require("express");
const router = express.Router();
const BlogPost = require("../models/blogpost.model");
const middleware = require("../middleware/middleware");

router.route("/Add").post(middleware, (req, res) => {
  const blogpost = BlogPost({
    postedBy: req.user._id,
    title: req.body.title,
    body: req.body.body,
    postImage:req.body.postImage
  });
  blogpost
    .save()
    .then((result) => {
      res.status(201).json({ data: result });
    })
    .catch((err) => {
      console.log(err), res.status(201).json({ err: err });
    });
});

router.route("/getAllBlogs").get(middleware, (req, res) => {
  BlogPost.find({})
  .populate("postedBy","username email img")
  .populate("comments.commentedBy","username email img")
  .populate("like","username email img")
  .then((s)=>{
    res.status(201).json({data:s})
  })
})

  router.route("/getMyBlog").get(middleware, (req, res) => {
    BlogPost.find({postedBy:req.user._id})
    .populate("postedBy","username email img")
    .populate("comments.commentedBy","username email img")
    .populate("like","username email img")
    .then((s)=>{
      res.status(201).json({data:s})
    })
});

router.route("/getOtherBlog").get(middleware, (req, res) => {
  BlogPost.find({ postedBy: { $ne: req.user._id } }, (err, result) => {
    if (err) return res.json(err);
    return res.status(201).json({ data: result });
  });
});

router.route("/delete/:id").delete(middleware, (req, res) => {
  BlogPost.findOneAndDelete(
    {
      $and: [{ postedBy: req.user._id }, { _id: req.params.id }],
    },
    (err, result) => {
      if (err) return res.json(err);
      else if (result) {
        console.log(result);
        return res.status(201).json("Blog deleted");
      }
      return res.json("Blog not deleted");
    }
  );
});


router.route("/likepost/:id").put(middleware,async(req,res)=>{
  console.log("Liking");
  BlogPost.findByIdAndUpdate(req.params.id,{
    $push:{
      like:req.user._id
    }
  },{new:true}).then((s)=>{
    console.log(s)
    res.status(201).json(s)
  })
});


router.route("/removeLike/:id").put(middleware,async(req,res)=>{
  BlogPost.findByIdAndUpdate(req.params.id,{
    $pull:{
      like:req.user._id
    }
  },{new:true}).then((s)=>{
    res.status(201).json(s)
  })
});



router.route("/comment/:id").put(middleware,async(req,res)=>{
  console.log(req.body);
  const comment ={
    Comment:req.body.Comment,
    commentedBy:req.user._id
  }; 
  BlogPost.findByIdAndUpdate(req.params.id,{
    $push:{
      comments:comment
    }
  },{new:true}).then((s)=>{
    console.log(s)
    res.status(201).json(s)
  })
});


router.route("/getUserBlog/:id").get(middleware,async(req,res)=>{
  console.log("Req :"+ req.params.id)
  BlogPost.find({postedBy:req.params.id})
  .populate("postedBy","username email img")
  .populate("comments.commentedBy","username email img")
  .populate("like","username email img")
  .then((da)=>{
    res.status(201).json({data:da})
  })
});




module.exports = router;
