const express = require("express");
const router = express.Router();

const userRouter = require("./user");
router.use("/user", userRouter);

const blogRouter = require("./blog");
router.use("/blog", blogRouter);

const storageRouter = require("./storage");
router.use("/storage", storageRouter);

module.exports = router;
