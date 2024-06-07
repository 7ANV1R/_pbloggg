// add a global logger for all api hit
module.exports = () => {
  return (req, res, next) => {
    const start = Date.now();
    res.on("close", () => {
      const end = Date.now();
      const responseTime = end - start;

      // Log response time along with other request details
      console.log(
        `${req.method} || ${req.url}\n${new Date()}\nAGENT ${
          req.headers["user-agent"]
        }\nHOST: ${req.headers["host"]}\nResponse time: ${responseTime}ms`
      );
    });

    next();
  };
};
