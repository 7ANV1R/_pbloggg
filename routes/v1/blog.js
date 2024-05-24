const express = require("express");
const blogRouter = express.Router();
const Blogs = require("../../controllers/blogs");

blogRouter.get("/", Blogs.GetAllBlog);
blogRouter.post("/create-blog", Blogs.CreateBlog);
blogRouter.get("/:id", Blogs.GetBlogDetails);
blogRouter.put("/update/:id", Blogs.UpdateBlog);
blogRouter.delete("/delete/:id", Blogs.DeleteBlog);

module.exports = blogRouter;
