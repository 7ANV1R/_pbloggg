const CoverUpload = async (req, res, next) => {
  try {
    // log form data
    // Log specific fields
    const ggField = req.body.gg;
    console.log("gg Field:", ggField);

    // Handle uploaded files
    let testfileField;
    if (req.files && req.files.length > 0) {
      req.files.forEach((file) => {
        if (file.fieldname === "testfile") {
          console.log("Testfile uploaded:", file.originalname);
          testfileField = file;
          // You can save or process the file here
        }
      });
    }

    res.send({
      message: "Cover uploaded successfully",
      gg: ggField,
      testfile: testfileField ? testfileField.originalname : null, // Include testfile field if it exists
    });
  } catch (error) {
    if (error) next(error);
  }
};

module.exports = { CoverUpload };
