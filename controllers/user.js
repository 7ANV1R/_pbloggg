const tokenGenerator = require("../middleware/jwt");
const User = require("../model/user.model");
const Token = require("../model/token.model");

const Login = async (req, res) => {
  return res.status(200).json({ message: "Login success" });
};

const Register = async (req, res) => {
  try {
    const newUser = new User(req.body);
    await newUser.save();

    // generate jwt
    const deviceId = req.body.device_id;
    const jwtToken = tokenGenerator({
      deviceId: deviceId ?? "ERR",
      userId: newUser._id ?? "ERR",
    });
    // save this jwt token in db
    const token = new Token({
      userId: newUser._id,
      token: jwtToken,
    });
    await token.save();
    return res.status(201).json({
      message: "User created successfully",
      token: jwtToken,
      user_data: _formattedUserData(newUser),
    });
  } catch (error) {
    console.log(error);
    if (error.code === 11000) {
      // MongoDB duplicate key error

      const duplicateField = Object.keys(error.keyPattern)[0];
      const errorMessage = `${duplicateField} already exists.`;
      return res.status(400).json({ error: errorMessage });
    }
    // For other errors, you can handle them accordingly
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
};

const _formattedUserData = (data) => {
  return {
    id: data._id,
    full_name: data.full_name ?? "N/A",
    email: data.email ?? null,
    interest: data.interest ?? [],
    createdAt: data.createdAt,
    updatedAt: data.updatedAt,
  };
};

module.exports = {
  Login,
  Register,
};
