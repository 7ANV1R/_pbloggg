const express = require("express");
const blogRouter = express.Router();
const Blogs = require("../../controllers/blogs");
const extractToken = require("../../middleware/extract.token");

blogRouter.get("/", Blogs.GetAllBlog);
blogRouter.post("/create-blog", extractToken, Blogs.CreateBlog);
blogRouter.get("/:id", Blogs.GetBlogDetails);
blogRouter.put("/update/:id", Blogs.UpdateBlog);
blogRouter.delete("/delete/:id", Blogs.DeleteBlog);

module.exports = blogRouter;
