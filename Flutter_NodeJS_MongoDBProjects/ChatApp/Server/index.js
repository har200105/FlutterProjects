const express = require('express');
const app = express();
require('dotenv').config();
const cors = require('cors');
app.use(express.json());
app.use(cors());
const connection = require('./database/db');
connection();
const bodyParser = require('body-parser');
app.use(bodyParser());



app.use('/',require('./routes/auth'));
app.use('/',require('./routes/chat'));
app.use('/',require('./routes/message'));

const PORT = process.env.PORT || 4000;

const server = app.listen(PORT,()=>{
    console.log("Server #KK");
});


const io = require('socket.io')(server,{
    cors:{
        origin:"*"
    }
})


let users = [];

const addUser = (userId, socketId) => {
    console.log('hi', userId, socketId)
    !users.some(user => user.userId === userId) && users.push({ userId, socketId });
}
   
const removeUser = (socketId) => {
    users = users.filter(user => user.socketId !== socketId);
}

const getUser = (userId) => {
    console.log(users);
    return users.find(user => user.userId === userId);
}

var clients = {};

io.on('connection',  (socket) => {
    console.log('user connected')
    console.log(socket.id);
    socket.on("entered",(id)=>{
        clients[id] = socket;
        console.log("Id : ",id);
        // console.log(clients[id]);
    });

    // //connect
    socket.on("addUser", userId => {
        addUser(userId, socket.id);
        io.emit("getUsers", users);
    })

    // //send message
    socket.on('sendMessage', ( senderId, receiverId, text ) => {
        console.log("Sender ID" + senderId);
        console.log("Text" + text);
        console.log("Reciever ID" + receiverId);
        if(clients[receiverId]){
            console.log("xd")
            clients[receiverId].emit('getMessage',{senderId,receiverId,text});
        }else{
            console.log(clients[receiverId])
            console.log("swd")
        }

        

        // const user = getUser(receiverId);
        // console.log('gg', user)
        // io.to(user.socketId).emit('getMessage', {
        //     senderId, text
        // })
    });
    socket.on('disconnect', () => {
        console.log('user disconnected');
        // removeUser(socket.id);
        // io.emit('getUsers', users);
    });
})


