const db = require("../config/firebase");
const admin = require("firebase-admin");

const saveHealthData = async (data) => {
  try {
    const now = new Date(data.timestamp);

    const date = now.toISOString().split("T")[0]; // YYYY-MM-DD
    const hour = now.getUTCHours();

    const ref = db
      .collection("health_data")
      .doc(date)
      .collection("hours")
      .doc(String(hour));

    await ref.set({
      date,
      hour,

      heart_sum: admin.firestore.FieldValue.increment(data.heart_rate || 0),
      resp_sum: admin.firestore.FieldValue.increment(data.respiration_rate || 0),

      // count for average
      count: admin.firestore.FieldValue.increment(1),

      posture_supine: admin.firestore.FieldValue.increment(data.posture === "supine" ? 1 : 0),
      posture_prone: admin.firestore.FieldValue.increment(data.posture === "prone" ? 1 : 0),
      posture_left: admin.firestore.FieldValue.increment(data.posture === "left" ? 1 : 0),
      posture_right: admin.firestore.FieldValue.increment(data.posture === "right" ? 1 : 0),

      // optional latest snapshot
      last_heart_rate: data.heart_rate,
      last_respiration_rate: data.respiration_rate,
      last_posture: data.posture,

      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

  } catch (error) {
    console.error("Firestore Error:", error);
  }
};

module.exports = { saveHealthData };