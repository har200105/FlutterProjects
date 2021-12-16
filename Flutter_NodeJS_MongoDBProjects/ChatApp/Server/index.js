const express = require('express');
const app = express();
require('dotenv').config();
const cors = require('cors');
app.use(express.json());
app.use(cors());
const connection = require('./database/db');
connection();



app.use('/',require('./routes/auth'));
app.use('/',require('./routes/chat'));
app.use('/',require('./routes/message'));

const PORT = process.env.PORT || 4000;

const server = app.listen(PORT,()=>{
    console.log("Server #KK");
});


const {Server} = require('socket.io');
 
const io = new Server(server)


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

io.on('connection',  (socket) => {
    console.log('user connected')

    //connect
    socket.on("addUser", userId => {
        addUser(userId, socket.id);
        io.emit("getUsers", users);
    })

    //send message
    socket.on('sendMessage', ({ senderId, receiverId, text }) => {
        console.log('hhhh', senderId, receiverId, text);
        const user = getUser(receiverId);
        console.log('gg', user)
        io.to(user.socketId).emit('getMessage', {
            senderId, text
        })
    })

    //disconnect
    socket.on('disconnect', () => {
        console.log('user disconnected');
        removeUser(socket.id);
        io.emit('getUsers', users);
    })
})


