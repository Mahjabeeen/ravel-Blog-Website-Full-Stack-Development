console.log("Starting server...");
const express = require("express");
const app = express();
const PORT = 5000;
app.get("/", (req, res) => {
    res.send("Server is working!");
});
app.get("/api/test", (req, res) => {
    res.json({ message: "API is working", timestamp: new Date() });
});
app.listen(PORT, () => {
    console.log("Server running on http://localhost:" + PORT);
});
