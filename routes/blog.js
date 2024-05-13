const express = require("express");
const blogRouter = express.Router();

blogRouter.get("/", (req, res) => {
  res.send({
    message: "Welcome to the blog page",
  });
});

module.exports = blogRouter;
