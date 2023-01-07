const mongoose = require("mongoose");

const faceSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  secureUrl: {
    type: String,
    requried: true,
  },
});

const Face = mongoose.model("Face", faceSchema);

module.exports = Face;
