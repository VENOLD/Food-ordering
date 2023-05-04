//import 'package:express/express.dart'
const express = require("express");
const  mongoose  = require("mongoose");
const adminRouter = require("./routes/admin");
const adminRouter2= require("./routes/admin2");
//import from other files
const authRouter=require('./routes/auth');
const foodRouter = require("./routes/food");
const foodRouter2 = require("./routes/food");
const userRouter = require("./routes/user");



const port =3000;
const app=express();
const DB="mongodb://127.0.0.1/";
app.use(express.json());

app.use(authRouter);

app.use(adminRouter);

app.use(adminRouter2);

app.use(foodRouter);

app.use(foodRouter2);

app.use(userRouter);




mongoose.connect(DB).then(()=>{
    console.log("connection successful");
})
.catch((e)=>{
    console.log(e);
});
app.listen(port,"0.0.0.0",()=>{
    console.log(`connected at port  ${port}`);
});