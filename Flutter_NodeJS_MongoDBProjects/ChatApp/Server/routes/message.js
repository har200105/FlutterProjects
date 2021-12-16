const router = require('express').Router();
const Message = require('../models/Message');
const Chat = require('../models/Chats');
const reqLogin = require('../middleware/reqLogin');
const User = require('../models/User');

router.get('/getMessages/:chatId',reqLogin,async (req, res) => {
    try {
        const messages = await Message.find({ chat: req.params.chatId })
            .populate("sender", "name email")
            .populate("chat");
        res.status(201).json(messages);
    } catch (error) {
        res.status(400);
        throw new Error(error.message);
    }
});


router.post('/sendMessage/:chatId',reqLogin,async(req,res)=>{
    const { content } = req.body;
    const chatId = req.params.chatId;

    if (!content || !chatId) {
      console.log("Invalid data passed into request");
      return res.sendStatus(400);
    }
  
    var newMessage = {
      sender: req.user._id,
      content: content,
      chat: chatId,
    };
  
    try {
      var message = await Message.create(newMessage);
  
      message = await message.populate("sender", "name email");
      message = await message.populate("chat");
      message = await User.populate(message, {
        path: "chat.users",
        select: "name email",
      });
  
      await Chat.findByIdAndUpdate(req.params.chatId , { latestMessage: message });
  
      res.status(201).json(message);
    } catch (error) {
      res.status(400);
      throw new Error(error.message);
    }
});


module.exports = router;