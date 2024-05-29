const Blogs = require("../model/blog.model");
const Token = require("../model/token.model");
const jwt = require("jsonwebtoken");

const GetAllBlog = async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;

  try {
    const totalBlogs = await Blogs.countDocuments({});
    const blogs = await Blogs.aggregate([
      { $sort: { _id: 1 } },
      { $skip: (page - 1) * limit },
      { $limit: limit },
      {
        $lookup: {
          from: "users", // Name of the users collection
          localField: "author", // Field in the blogs collection
          foreignField: "_id", // Field in the users collection
          as: "authorDetails", // Output array field
        },
      },
      { $unwind: "$authorDetails" }, // Convert array to object
      {
        $project: {
          _id: 1,
          title: 1,
          cover: { $ifNull: ["$cover", null] },
          createdAt: 1,
          updatedAt: 1,
          authorDetails: {
            _id: "$authorDetails._id",
            full_name: "$authorDetails.full_name",
            email: "$authorDetails.email",
            cover: { $ifNull: ["$authorDetails.cover", null] },
          },
        },
      },
      {
        $addFields: {
          author: "$authorDetails",
        },
      },
      {
        $project: {
          authorDetails: 0,
        },
      },
    ]);
    const nextPage = page < Math.ceil(totalBlogs / limit) ? page + 1 : null;
    const prevPage = page > 1 ? page - 1 : null;

    return res.status(200).json({
      pagination: {
        total: totalBlogs,
        currentPage: page,
        perPage: limit,
        nextPage: nextPage,
        prevPage: prevPage,
      },
      data: blogs,
    });
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
    const formattedData = await _formattedFullBlog(newBlog);
    return res.status(201).json(formattedData);
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
      const formattedData = await _formattedFullBlog(item);

      return res.status(200).json(formattedData);
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
    const formattedData = await _formattedFullBlog(updatedItem);
    return res.status(200).json(formattedData);
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

const _formattedPreviewBlog = async (item) => {
  const User = require("../model/user.model");
  const author = await User.findById(item.author._id);
  return {
    id: item._id,
    title: item.title ?? "N/A",
    cover: item.cover ?? null,
    createdAt: item.createdAt,
    updatedAt: item.updatedAt,
    author: {
      id: author._id,
      name: author.full_name,
      email: author.email,
      cover: author.cover ?? null,
    },
  };
};

const _formattedFullBlog = async (item) => {
  const User = require("../model/user.model");
  const author = await User.findById(item.author);
  return {
    id: item._id,
    title: item.title ?? "N/A",
    cover: item.cover ?? null,
    content: item.content ?? "",
    createdAt: item.createdAt,
    updatedAt: item.updatedAt,
    author: {
      id: author._id,
      name: author.full_name,
      email: author.email,
      cover: author.cover ?? null,
    },
  };
};

module.exports = {
  GetAllBlog,
  CreateBlog,
  GetBlogDetails,
  UpdateBlog,
  DeleteBlog,
};
