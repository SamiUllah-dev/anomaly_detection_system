const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");

const PORT = 3000;
const app = express();
const DB =
  "mongodb+srv://samiullah:samiullah0604@cluster0.gwewkjf.mongodb.net/?retryWrites=true&w=majority";
app.use(express.json());
app.use(authRouter);

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
