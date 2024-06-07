const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const userSchema = new mongoose.Schema(
  {
    full_name: {
      type: String,
      // validation message
      required: [true, "Name is required"],
    },
    email: {
      type: String,
      required: true,
      unique: true,
    },
    drowssap: {
      type: String,
      required: true,
    },

    // list of interest
    interest: {
      type: [String],
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

userSchema.pre("save", async function (next) {
  const userValue = this;

  if (!userValue.isModified("drowssap")) return next();

  try {
    // hash the pass
    const salt = await bcrypt.genSalt(10);
    const hashedPass = await bcrypt.hash(userValue.drowssap, salt);
    userValue.drowssap = hashedPass;
    next();
  } catch (error) {
    return next(error);
  }
});

// compare pass
userSchema.methods.comparePass = async function (pass) {
  try {
    return await bcrypt.compare(pass, this.drowssap);
  } catch (error) {
    throw error;
  }
};

module.exports = mongoose.model("User", userSchema);
