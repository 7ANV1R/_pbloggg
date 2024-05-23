const mongoose = require("mongoose");

const blogSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      // validation message
      required: [true, "Title is required"],
    },
    content: {
      type: String,
      required: true,
    },

    cover: {
      type: String,
    },

    // active
    active: {
      type: Boolean,
      default: true,
    },
  },
  // timestamps
  { timestamps: true }
);

const Blog = mongoose.model("Blog", blogSchema);

module.exports = Blog;
