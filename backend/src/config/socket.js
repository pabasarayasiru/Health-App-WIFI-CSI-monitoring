const { Server } = require("socket.io");
const initHealthSocket = require("../sockets/healthSocket");

const setupSocket = (server) => {
  const io = new Server(server, {
    cors: {
      origin: "*",
    },
  });

  initHealthSocket(io);
};

module.exports = setupSocket;