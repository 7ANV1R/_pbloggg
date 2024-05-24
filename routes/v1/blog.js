const express = require("express");
const blogRouter = express.Router();
const Blogs = require("../../controllers/blogs");

blogRouter.get("/", Blogs.GetAllBlog);
blogRouter.post("/create-blog", Blogs.CreateBlog);
blogRouter.get("/:id", Blogs.GetBlogById);

module.exports = blogRouter;
