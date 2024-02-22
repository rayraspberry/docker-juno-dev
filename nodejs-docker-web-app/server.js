import express from "express";
import { execSync } from "child_process";

const PORT = process.env.PORT || 8080;

const app = express();

app.get("/", (req, res) => {
  const result = execSync("junod");
  res.json({ message: "Hello from server!", result: result.toString() });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
