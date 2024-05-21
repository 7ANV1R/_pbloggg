const express = require("express");
const storageRouter = express.Router();
const upload = require("../middleware/upload");
const Storage = require("../controllers/storage");

storageRouter.post("/cover", upload.array("files", 10), Storage.CoverUpload);

module.exports = storageRouter;
