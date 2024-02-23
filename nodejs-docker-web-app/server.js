import express from "express";
import { execSync } from "child_process";

const PORT = process.env.PORT || 8080;

const app = express();

/** RULES OF OUR API */
app.use((req, res, next) => {
  // set the CORS policy
  res.header("Access-Control-Allow-Origin", "*");
  // set the CORS headers
  res.header("Access-Control-Allow-Headers", "origin, X-Requested-With,Content-Type,Accept, Authorization");
  // set the CORS method headers
  if (req.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "GET");
    return res.status(200).json({});
  }
  next();
});

app.get("/", (req, res) => {
  const result = execSync("junod");
  res.json({ message: "Hello from server!", result: result.toString() });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
