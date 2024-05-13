// multer middleware for handling form data
const multer = require("multer");
const upload = multer();

const handleFormData = upload.any();

module.exports = handleFormData;
