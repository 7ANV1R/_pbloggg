// add a global logger for all api hit
module.exports = () => {
  return (req, res, next) => {
    console.log(`${req.method} || ${req.url}`);
    next();
  };
};
