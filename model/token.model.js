const mongoose = require("mongoose");

const tokenSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    token: {
      type: String,
      required: true,
    },
    deviceId: {
      type: String,
      required: true,
      unique: true, // Enforce device ID uniqueness
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Token", tokenSchema);
