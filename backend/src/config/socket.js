// const { Server } = require("socket.io");
const { initHealthSocketIO, initHealthSocketWS, initHealthSocketWSReal } = require("../sockets/healthSocket");
const { WebSocketServer, WebSocket } = require("ws");

// const setupSocket = (server) => {
//   const io = new Server(server, {
//     cors: {
//       origin: "*",
//     },
//   });

//   initHealthSocketIO(io);
// };



const setupSocket = (server) => {
  const wss = new WebSocketServer({ server });
  // initHealthSocketWS(wss);
  initHealthSocketWSReal(wss);
};



module.exports = setupSocket;