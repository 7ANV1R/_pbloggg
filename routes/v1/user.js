const express = require("express");
const userRouter = express.Router();
const User = require("../../controllers/user");

userRouter.post("/login", User.Login);
userRouter.post("/register", User.Register);

module.exports = userRouter;
