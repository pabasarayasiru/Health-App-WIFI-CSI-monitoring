const db = require("../config/firebase");

const saveHealthData = async (data) => {
  try {
    await db.collection("health_data").add(data);
  } catch (error) {
    console.error("Firestore Error:", error);
  }
};

module.exports = { saveHealthData };