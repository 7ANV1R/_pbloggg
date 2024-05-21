const axios = require("axios");
const FormData = require("form-data");
const fs = require("fs");

const CoverUpload = async (req, res, next) => {
  const files = req.files;
  const successfulUploads = [];
  const failedUploads = [];

  if (!files || files.length === 0) {
    return res.status(400).send("No files were uploaded.");
  }

  const token = `Bearer ${process.env.SUPABASE_API_KEY}`;

  try {
    for (const file of files) {
      try {
        await sendFileToExternalServer(file, token);
        successfulUploads.push(file.originalname);
      } catch (error) {
        console.error(`Failed to upload ${file.originalname}:`, error.message);
        failedUploads.push(file.originalname);
      } finally {
        fs.unlink(file.path, (err) => {
          if (err) {
            console.error(`Failed to delete file ${file.path}:`, err.message);
          }
        });
      }
    }
    res.status(200).json({ successfulUploads, failedUploads });
  } catch (error) {
    console.error("An error occurred while uploading files:", error.message);
    res.status(500).send("An error occurred while uploading files.");
  }
};

const sendFileToExternalServer = async (file, token) => {
  const supabaseUrl = `${process.env.SUPABASE_BLOG_CONTENT_URL}/${
    file.originalname
  }-${Date.now()}`;
  const formData = new FormData();
  formData.append("", fs.createReadStream(file.path), file.originalname);

  const headers = {
    ...formData.getHeaders(),
    Authorization: token,
  };

  const response = await axios.post(supabaseUrl, formData, { headers });

  return response.data;
};

module.exports = { CoverUpload };
