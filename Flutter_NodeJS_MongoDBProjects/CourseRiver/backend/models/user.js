const mongoose = require('mongoose');
const { ObjectId } = mongoose.Schema.Types;
const userSchema = new mongoose.Schema({
   
    email: {
        type: String,
        required: true,
    },

    password: {
        type: String,
        required: true,
    },

    name: {
        type: String,
        required: true,
    },

    image:{
        type:String,
        default:"https://image.shutterstock.com/image-vector/avatar-vector-male-profile-gray-260nw-538707355.jpg"
    },

    ratingsGiven: [{
        type: ObjectId,
        ref: "Courses"
    }],

    isAdmin:{
        type:Boolean,
        default:false
    }

})

const User = mongoose.model("User", userSchema);

module.exports = User;