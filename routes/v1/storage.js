const express = require("express");
const storageRouter = express.Router();

const uploadHandler = require("../../middleware/upload.handler");
const Storage = require("../../controllers/storage");

storageRouter.post("/cover", uploadHandler, Storage.CoverUpload);

module.exports = storageRouter;
