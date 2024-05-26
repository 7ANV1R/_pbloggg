const jwt = require("jsonwebtoken");

const generateToken = (data) => {
  // Generate a new JWT token using user data
  return jwt.sign(data, process.env.JWT_SECRET);
};

module.exports = generateToken;
