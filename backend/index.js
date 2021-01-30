require("dotenv").config();
const express = require("express");
const app = express();
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const mongoSantize = require("express-mongo-sanitize")
const PORT = process.env.PORT || 4000;

//ROUTES
const userRoute = require('./routes/userRoute')
const plRoute= require('./routes/plRoute')

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.set("port", PORT);
app.use(cors());
app.use(mongoSantize())

var server = app.listen(PORT, () => {
  console.log("server listening at " + PORT);
});
//

mongoose
  .connect(`${process.env.DATABASE}`, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: false,
  })
  .then(
    () => {
      console.log("Connected to database");
      // app.use("/api/admin", AdminRoutes);
      app.use("/api/user", userRoute);
       app.use('/api/pl', plRoute)
    },
    (err) => {
      console.log(err);
      console.log("Connection Failed retry");
    }
  );





//working check
app.get("/", async (req, res) => {
  return res.json({ message: "working" });
});

//Mail.signup()
