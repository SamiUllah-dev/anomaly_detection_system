const express = require("express");
const Person = require("../models/person");

const communityRoute = express.Router();

module.exports = communityRoute;

communityRoute.post("/api/addPerson", async (req, res) => {
  console.log(res.body);
  try {
    const { name, phoneNumber } = req.body;
    console.log("Name : " + name);
    console.log("PhoneNumber : " + phoneNumber);
    let person = new Person({ name, phoneNumber });
    person = await person.save();
    res.json(person);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

communityRoute.get("/api/getPeople", async (req, res) => {
  try {
    const people = await Person.find({});
    res.json(people);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete person
communityRoute.post("/api/deletePerson", async (req, res) => {
  try {
    const { id } = req.body;
    let person = await Person.findByIdAndDelete(id);
    res.json(person);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

communityRoute.post("/api/updatePerson", async (req, res) => {
  try {
    const { id, name, phoneNumber } = req.body;
    let person = await Person.findByIdAndUpdate(id, { name, phoneNumber });
    res.json(person);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
