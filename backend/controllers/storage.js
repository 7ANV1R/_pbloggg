const axios = require("axios");
const FormData = require("form-data");
const fs = require("fs");

const CoverUpload = async (req, res) => {
  const files = req.files;
  const successfulUploads = [];
  const failedUploads = [];

  if (!files || files.length === 0) {
    return res.status(400).json({ successfulUploads, failedUploads });
  }

  const token = `Bearer ${process.env.SUPABASE_API_KEY}`;

  try {
    for (const file of files) {
      try {
        const now = new Date().toISOString();
        console.log(file.originalname);
        await sendFileToExternalServer(file, token, now);
        successfulUploads.push(`${now}-${file.originalname}`);
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
    res.status(500).json({ error: error.message });
  }
};

const sendFileToExternalServer = async (file, token, now) => {
  const supabaseUrl = `${process.env.SUPABASE_BLOG_CONTENT_URL}/${now}-${file.originalname}`;
  const formData = new FormData();
  formData.append("", fs.createReadStream(file.path), file.originalname);

  const headers = {
    ...formData.getHeaders(),
    Authorization: token,
  };

  const response = await axios.post(supabaseUrl, formData, { headers });
  console.log(`response: ${response}`);
  return response.data;
};

module.exports = { CoverUpload };
