const multer = require("multer");
const fs = require("fs");

const uploadDir = "uploads/";
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024, // Limit file size to 5MB
  },
});

const fileUploadHandler = (req, res, next) => {
  upload.array("files", 20)(req, res, (err) => {
    if (err instanceof multer.MulterError && err.code === "LIMIT_FILE_SIZE") {
      return res
        .status(400)
        .json({ error: "File size must be less than 5 MB" });
    }
    // handle 20 files limit err
    else if (
      err instanceof multer.MulterError &&
      err.code === "LIMIT_UNEXPECTED_FILE"
    ) {
      return res
        .status(400)
        .json({ error: "You can only upload up to 20 files at once" });
    } else if (err) {
      return res
        .status(500)
        .json({ error: "An error occurred while uploading files" });
    }
    next();
  });
};
module.exports = fileUploadHandler;
