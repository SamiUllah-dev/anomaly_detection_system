const express = require("express");
const Face = require("../models/face");

const faceRegistration = express.Router();

module.exports = faceRegistration;

faceRegistration.post("/api/faceIsRegistred", async (req, res) => {
  try {
    const { name } = req.body;
    const faceExists = await Face.findOne({ name });
    if (faceExists) {
      res.status(300).json({ msg: "already-registered" });
      return;
    }
    res.status(200).json({ msg: "does-not-exist" });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

faceRegistration.get("/api/get-faces", async (req, res) => {
  try {
    const faces = await Face.find({});
    res.json(faces);
  } catch (e) {
    res.status(500).json({ error: "something went wrong!" });
  }
});

faceRegistration.post("/api/delete-face", async (req, res) => {
  try {
    const { name } = req.body;
    const existingFace = await Face.findOne({ name });
    if (!existingFace) {
      res.status(300).json({ msg: "not-registered" });
      return;
    }
    await Face.findOneAndDelete({ name });
    res.json({ msg: "deleted" });
  } catch (e) {
    res.status(500).json({ error: "something went wrong!" });
  }
});

faceRegistration.post("/api/register-face", async (req, res) => {
  try {
    const { name, secureUrl } = req.body;
    let face = new Face({
      name,
      secureUrl,
    });
    face = await face.save();
    res.status(200).json({ msg: "added" });
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e.message);
  }
});
