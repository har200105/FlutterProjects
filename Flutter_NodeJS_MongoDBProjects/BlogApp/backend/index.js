const express = require("express");
const mongoose = require("mongoose");
const PORT = process.env.PORT || 5000;
const app = express();

mongoose.connect(
  "mongodb+srv://harshit:harshit@cluster0.mj9xh.mongodb.net/myFirstDatabase?retryWrites=true&w=majority",
  {
    useNewUrlParser: true,
    useCreateIndex: true,
    useUnifiedTopology: true,
  }
);

const connection = mongoose.connection;
connection.once("open", () => {
  console.log("Database Connected");
});

app.use(express.json());
const userRoute = require("./routes/user");
app.use("/user", userRoute);
const blogRoute = require("./routes/blogpost");
app.use("/blogPost", blogRoute);


app.listen(PORT, () =>{
  console.log("SERVER OP");
});
