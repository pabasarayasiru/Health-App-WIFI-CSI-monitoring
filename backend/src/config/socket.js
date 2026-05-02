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

  console.log("WebSocket server initialized");

  // initHealthSocketWS(wss); 
  initHealthSocketWSReal(wss);

  wss.on("connection", (ws) => {
    console.log("WebSocket client connected");
  });

  wss.on("error", (err) => {
    console.error("WebSocket server error:", err);
  });
};


module.exports = setupSocket;