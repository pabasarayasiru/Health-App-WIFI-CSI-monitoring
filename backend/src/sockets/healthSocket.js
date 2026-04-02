const { saveHealthData } = require("../services/firebaseService");

const initHealthSocket = (io) => {

  io.on("connection", (socket) => {
    console.log("Client connected:", socket.id);

    const interval = setInterval(async () => {

      // 🔴 Fake realtime data (replace later with ML)
      const data = {
        heart_rate: Math.floor(Math.random() * 40) + 60,
        respiration_rate: Math.floor(Math.random() * 10) + 12,
        posture: ["sitting", "standing", "sleeping"][Math.floor(Math.random() * 3)],
        timestamp: new Date(),
      };

      // Send to client
      socket.emit("health_data", data);

      // Save to Firestore
      await saveHealthData(data);

    }, 2000);

    socket.on("disconnect", () => {
      console.log("Client disconnected:", socket.id);
      clearInterval(interval);
    });
  });
};

module.exports = initHealthSocket;