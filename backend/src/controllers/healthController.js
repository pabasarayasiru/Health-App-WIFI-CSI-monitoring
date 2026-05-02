const db = require("../config/firebase");

const getDailyAnalytics = async (req, res) => {
  try {
    const { date } = req.query;
    if (!date) return res.status(400).json({ error: "date required" });

    const snapshot = await db
      .collection("health_data")
      .doc(date)
      .collection("hours")
      .get();

    let totalHeart = 0;
    let totalResp = 0;
    let totalCount = 0;

    const posture = {
      supine: 0,
      prone: 0,
      left: 0,
      right: 0,
      unknown: 0
    };

    const hourly = [];

    for (let i = 0; i < 24; i++) {
      hourly.push({
        hour: i,
        avg_heart_rate: 0,
        avg_respiration_rate: 0
      });
    }

    snapshot.forEach(doc => {
      const h = Number(doc.id);
      const d = doc.data();

      const count = d.count || 0;

      const avgHeart = count ? d.heart_sum / count : 0;
      const avgResp = count ? d.resp_sum / count : 0;

      // hourly chart
      hourly[h] = {
        hour: h,
        avg_heart_rate: avgHeart,
        avg_respiration_rate: avgResp
      };

      // daily totals
      totalHeart += d.heart_sum || 0;
      totalResp += d.resp_sum || 0;
      totalCount += count;

      // posture estimation (from last known values)
      posture.supine += d.posture_supine || 0;
      posture.prone += d.posture_prone || 0;
      posture.left += d.posture_left || 0;
      posture.right += d.posture_right || 0;
    });

    // convert posture to percentages
    const postureTotal = Object.values(posture).reduce((a, b) => a + b, 0);

    const posturePercent = {};
    for (const key in posture) {
      posturePercent[key] = postureTotal
        ? ((posture[key] / postureTotal) * 100).toFixed(2)
        : 0;
    }

    const result = {
      date,

      // 1. daily average cards
      daily: {
        avg_heart_rate: totalCount ? totalHeart / totalCount : 0,
        avg_respiration_rate: totalCount ? totalResp / totalCount : 0,
        total_records: totalCount
      },

      // 2. posture pie chart
      posture: posturePercent,

      // 3. hourly bar chart
      hourly,

      // 4. metadata
      meta: {
        hours_available: snapshot.size
      }
    };

    res.json(result);

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
};

module.exports = { getDailyAnalytics };