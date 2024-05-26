const Blogs = require("../model/blog.model");
const Token = require("../model/token.model");
const jwt = require("jsonwebtoken");

const GetAllBlog = async (req, res) => {
  try {
    const items = await Blogs.find({});
    const newItem = items.map(_formattedPreviewBlog);
    return res.status(200).json(newItem);
  } catch (error) {
    return res.status(500).send(error.message);
  }
};

const CreateBlog = async (req, res) => {
  try {
    if (!req.token) {
      return res.status(401).json({
        error: "Unauthorized! Access token is missing.",
      });
    }
    const fullToken = req.token;

    // decode json token then get the user id
    const userId = await jwt.verify(fullToken, process.env.JWT_SECRET).userId;
    // check this token in token db with same userId and same token
    const userTokenObject = await Token.findOne({ userId, token: fullToken });
    if (!userTokenObject) {
      return res.status(403).json({ error: "Invalid token" });
    }
    // create blog
    const newBlog = new Blogs({ ...req.body, author: userId });

    await newBlog.save();
    return res.status(201).json(_formattedFullBlog(newBlog));
  } catch (error) {
    console.error(`Error: ${error.code} ${error}`);
    if (error.name === "ValidationError") {
      const formattedError = Object.values(error.errors).map(
        (val) => val.message
      );
      return res.status(403).json({ error: `${formattedError.join(", ")}.` });
    }
    return res.status(500).json({ error: error.message });
  }
};

const GetBlogDetails = async (req, res) => {
  try {
    const item = await Blogs.findById(req.params.id);
    if (item) {
      return res.status(200).json(_formattedFullBlog(item));
    }
    return res.status(404).json({ error: "Aw snap! Blog not found" });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// update blog
const UpdateBlog = async (req, res) => {
  try {
    const { id } = req.params;
    const item = await Blogs.findByIdAndUpdate(id, req.body);
    if (!item) {
      return res.status(404).json({ error: "Aw snap! Blog not found" });
    }
    const updatedItem = await Blogs.findById(id);
    return res.status(200).json(_formattedFullBlog(updatedItem));
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

const DeleteBlog = async (req, res) => {
  try {
    const item = await Blogs.findByIdAndDelete(req.params.id);
    if (!item) {
      return res.status(404).json({ error: "Aw snap! Blog not found" });
    }
    return res.status(200).json({
      message: "Blog deleted successfully",
    });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

const _formattedPreviewBlog = (item) => {
  return {
    id: item._id,
    title: item.title ?? "N/A",
    cover: item.cover ?? null,
    createdAt: item.createdAt,
    updatedAt: item.updatedAt,
  };
};

const _formattedFullBlog = (item) => {
  return {
    id: item._id,
    title: item.title ?? "N/A",
    cover: item.cover ?? null,
    content: item.content ?? "",
    createdAt: item.createdAt,
    updatedAt: item.updatedAt,
  };
};

module.exports = {
  GetAllBlog,
  CreateBlog,
  GetBlogDetails,
  UpdateBlog,
  DeleteBlog,
};
