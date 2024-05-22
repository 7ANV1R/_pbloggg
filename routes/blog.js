const express = require("express");
const blogRouter = express.Router();
const Blogs = require("../controllers/blogs");

blogRouter.get("/", (req, res) => {
  res.send({
    message: "Welcome to the blog page",
  });
});

blogRouter.post("/create-blog", Blogs.CreateBlog);

module.exports = blogRouter;
