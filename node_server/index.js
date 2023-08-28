const express = require("express");
const app = express();
// const dotenv = require('dotenv');


// this method allows us to load variables form dotenv file.
// dotenv.config();


app.listen(5002, () => console.log(`Example app listening on port {process.env.PORT}!`))