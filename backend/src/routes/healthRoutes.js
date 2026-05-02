const express = require("express");
const router = express.Router();

const {
  getDailyAnalytics: getDailyAverage
} = require("../controllers/healthController");

router.get("/analytics", getDailyAverage);

module.exports = router;