const Blogs = require("../model/blog.model");

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
    const item = await Blogs.create(req.body);
    return res.status(201).json(item);
  } catch (error) {
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
    return res.status(500).send(error.message);
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

module.exports = { GetAllBlog, CreateBlog, GetBlogById: GetBlogDetails };
