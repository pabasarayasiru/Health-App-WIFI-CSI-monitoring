const { saveHealthData } = require("../services/firebaseService");



const initHealthSocketIO = (io) => {

  io.on("connection", (socket) => {
    console.log("Client connected:", socket.id);

    const interval = setInterval(async () => {

      // Fake realtime data (replace later with ML)
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







const initHealthSocketWS = (wss) => {
  wss.on("connection", (ws) => {
    console.log("WebSocket client connected");

    const interval = setInterval(async () => {
      const data = {
        heart_rate: Math.floor(Math.random() * 40) + 60,
        respiration_rate: Math.floor(Math.random() * 10) + 12,
        posture: ["sitting", "standing", "sleeping"][
          Math.floor(Math.random() * 3)
        ],
        timestamp: new Date(),
      };

      // send data to this client
      ws.send(JSON.stringify({
        type: "health_data",
        payload: data
      }));

      // save to Firestore
      await saveHealthData(data);

    }, 2000);

    ws.on("message", (message) => {
      console.log("Received:", message.toString());
    });

    ws.on("close", () => {
      console.log("WebSocket client disconnected");
      clearInterval(interval);
    });

    ws.on("error", (err) => {
      console.error("WebSocket error:", err);
    });
  });
};





























const initHealthSocketWSReal = (wss) => {

  let latestData = {
    heart_rate: null,
    respiration_rate: null,
    posture: null,
    timestamp: null,
  };

  setInterval(async () => {
    try {
      if (latestData.timestamp) {
        await saveHealthData(latestData);
        console.log("Saved to Firebase");
      }
    } catch (err) {
      console.error("Firebase save error:", err);
    }
  }, 5000);

  wss.on("connection", (ws) => {
    console.log("Client connected");

    ws.on("message", (message) => {
      try {
        const msg = JSON.parse(message.toString());

        if (msg.type === "health_data") {
        const data = msg.payload;

        if (data.heart_rate !== undefined) {
          latestData.heart_rate = data.heart_rate;
        }

        if (data.respiration_rate !== undefined) {
          latestData.respiration_rate = data.respiration_rate;
        }

        if (data.posture !== undefined) {
          latestData.posture = data.posture;
        }

        latestData.timestamp = new Date();

        // broadcast
        wss.clients.forEach((client) => {
          if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify({
              type: "health_data",
              payload: latestData
            }));
          }
        });
      }

    } catch (err) {
        console.error("Invalid message:", err);
      }
    });

    ws.on("close", () => {
      console.log("Client disconnected");
    });

    ws.on("error", (err) => {
      console.error("WebSocket error:", err);
    });
  });
};


module.exports = { initHealthSocketIO, initHealthSocketWS, initHealthSocketWSReal };












/*

receiver

const WebSocket = require("ws");

const ws = new WebSocket("ws://localhost:3000"); 
// change to wss://your-app.onrender.com after deploy

ws.on("open", () => {
  console.log("Connected to backend");

  setInterval(() => {
    // 🔥 Replace these with real ML outputs
    const heartRate = Math.floor(Math.random() * 40) + 60;
    const respiration = Math.floor(Math.random() * 10) + 12;
    const postureList = ["sitting", "standing", "sleeping"];

    const data = {
      heart_rate: heartRate,
      respiration_rate: respiration,
      posture: postureList[Math.floor(Math.random() * 3)],
    };

    ws.send(JSON.stringify(data));
  }, 1000);
});

ws.on("close", () => {
  console.log("Disconnected");
});

*/