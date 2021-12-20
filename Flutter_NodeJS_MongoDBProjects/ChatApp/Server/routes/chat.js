const router = require('express').Router();
const Chat = require('../models/Chats');
const reqLogin = require('../middleware/reqLogin');
const User = require('../models/User');

router.get('/getChats',reqLogin,async(req,res)=>{
    try {
        await Chat.find({ users: { $elemMatch: { $eq: req.user._id } } })
          .populate("users", "-password")
          // .populate("latestMessage")
          .sort({ updatedAt: -1 })
          .then(async (results) => {
            // results = await User.populate(results, {
            //   path: "latestMessage.sender",
            //   select: "name email",
            // });
            console.log(results)
            res.status(201).json(results);
          });
      } catch (error) {
        res.status(400);
        throw new Error(error.message);
      }
});

router.post('/startChat/:id',reqLogin,async(req,res)=>{
    const userId = req.params.id;



    if (!userId) {
      return res.sendStatus(400);
    }

    const user = await User.findById(userId);
  
    var isChat = await Chat.find({
      $and: [
        { users: { $elemMatch: { $eq: req.user._id } } },
        { users: { $elemMatch: { $eq: userId } } },
      ],
    })
      .populate("users", "-password")
    isChat = await User.populate(isChat, {
      path: "latestMessage.sender",
      select: "name email",
    });
  
    if (isChat.length > 0) {
      res.status(201).send(isChat[0]);
    } else {
      var chatData = {
        chatName:user.name,  
        users: [req.user._id, userId],
      };
  
      try {
        const createdChat = await Chat.create(chatData);
        const FullChat = await Chat.findOne({ _id: createdChat._id }).populate(
          "users",
          "-password"
        );
        res.status(200).json(FullChat);
      } catch (error) {
        res.status(400);
        throw new Error(error.message);
      }
    }
});


module.exports =  router;