const jwt = require('jsonwebtoken');  
const config = require('../config');
const User = require('../models/users.model');

module.exports = (req, res, next) => {
    const { authorization } = req.headers;
    if (!authorization) {
        res.status(401).json({ error: "You are not Logged In !!" });
    }

    jwt.verify(authorization,config.key, (err, payload) => {

        console.log(payload)
        
        if (err) {
            return res.status(401).json({ error: "You must be logged in" });
        }
        console.log(payload);
        const { _id } = payload;
        User.findById({ _id }).then(userData => {
            console.log(userData)
            req.user = userData;
            next();
        })
    })
}