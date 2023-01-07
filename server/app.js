const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const communityRoute = require("./routes/community");
const faceRegistration = require("./routes/face_registration");

const PORT = 3000;
const app = express();
const DB = "<your mongodb driver>";
app.use(express.json());
app.use(authRouter);
app.use(communityRoute);
app.use(faceRegistration);

mongoose.set("strictQuery", false);
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Conntect at port ${PORT}`);
});
