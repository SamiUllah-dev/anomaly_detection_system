const mongoose = require("mongoose");

const personScheme = mongoose.Schema({
  name: {
    required: true,
    type: String,
  },

  phoneNumber: {
    required: true,
    type: String,
  },
});

const Person = mongoose.model("Person", personScheme);
module.exports = Person;
