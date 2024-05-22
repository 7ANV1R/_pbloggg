const Blogs = require("../model/blog_model");

const CreateBlog = async (req, res) => {
  try {
    const item = await Blogs.create(req.body);
    return res.status(201).json(item);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

module.exports = { CreateBlog };
