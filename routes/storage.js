const express = require("express");
const storageRouter = express.Router();
const handleFormData = require("../middleware/handle_form_data");
const Storage = require("../controllers/storage");

storageRouter.post("/cover", handleFormData, Storage.CoverUpload);

module.exports = storageRouter;
