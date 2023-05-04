const express = require('express');
const adminRouter=  express.Router();
const admin =require('../middlewares/admin');
const {Food}=require("../models/food");
const Order = require('../models/order');
const Admin=require('../models/admin');
const jwt= require('jsonwebtoken');
const bcryptjs = require("bcryptjs");
//add food 
adminRouter.route("/update/:phoneNumber", async(req,res)=>{
  Admin.findByIdAndUpdate(
    {phoneNumber:req.params.phoneNumber},
    {$set:{password:req.body.password}},
    (error,results)=>{
      if(error) return res.status(500).json({msg:error});
      const msg={
      msg:"password successfully updated",
      phoneNumber:req.params.phoneNumber
      };
      return res.json(msg);
    }
  )
})

adminRouter.post("/api/signup-admin",async function(req,res){
  try{
    const {name,phoneNumber,password}= req.body;
   
    const existingUser= await Admin.findOne({phoneNumber});
    
    if(existingUser){
          
     return res.status(400).json({msg:" Admin With Same phone \n number Already Exists!\n Please Sign In"});
    
     } 
     const hashedPassword = await bcryptjs.hash(password, 6);
  
   let admin =new Admin({
    phoneNumber,
    name,
    password: hashedPassword,

   
   });
  admin= await admin.save();
  res.json(admin);
  }
  catch(e){
    res.status(500).json({error:e.message});
  
  
  }});
  adminRouter.post('/api/signin-admin', async(req,res)=>{
    try{
      const {phoneNumber, password} = req.body;
      const admin=await Admin.findOne({phoneNumber});
      if(!admin){
        return res.status(400).json({msg:"Admin With This phone number Does Not Exist!"});
      }
      const isMatch = await (password, admin.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }
      if(!phoneNumber){
        return res.status(400).json({msg:"Incorrect Phone number!"});
      }
      const token= jwt.sign({id: admin._id},'passwordKey');
      res.json({token, ...admin._doc});
  
    }catch(e){
      res.status(500).json({error:e.message}); 
  
    }
  });
  adminRouter.post("/tokenIsValid", async(req,res)=>{
    try{
      const token =req.header('x-auth-token');
      if(!token) return res.json(false);
      const verified =jwt.verify(token,'passwordKey');
      if(!verified) return res.json(false);
       
      const admin =await Admin.findById(verified.id);
      if(!admin) return res.json(false);
      res.json(true);
  
    }catch(e){
      res.status(500).json({error:e.message}); 
     
  
    }
  });
  //get user data
  adminRouter.get("/",admin,async(req,res)=>{
    const admin=await Admin.findById(req.admin);
    res.json({...admin._doc,token:req.token});
  })
 
adminRouter.post('/admin/add-food',admin, async(req,res)=>{
    try{
     const {name,description,images,quantity,price,category,vat }=req.body;
     let food = new Food ({
       name,
       description,
       images,
       quantity,
       price,
       category,
       vat,

     });
     food = await  food.save();
     res.json(food);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
} );


adminRouter.get('/admin/get-food',admin, async(req,res)=>{
  try{
    const food =await Food.find({});
    res.json(food);

  }catch(e){
    res.status(500).json({error:e.message});
  }
});
//delete the foods/drinks

adminRouter.post('/admin/delete-food',admin, async(req, res)=>{
  try{
  const {id}=req.body;
  let food=await Food.findByIdAndDelete(id);
res.json(food); 
  }catch(e){
    res.status(500).json({error:e.message});
  }
});
// update the quantity

adminRouter.post('/admin/change-order-status',admin, async(req, res)=>{
  try{
  const {id, status}=req.body;
  let order=await Order.findById(id);
  order.status = status;
  order= await order.save();
res.json(order);
  }catch(e){
    res.status(500).json({error:e.message});
  }
});
adminRouter.post('/admin/isNotAvailable',admin, async(req, res)=>{
  try{
  const {id, isAvailable}=req.body;
  let food=await Food.findByIdAndUpdate(id);
  food.isAvailable = isAvailable;
  food= await food.save();
res.json(food);
  }catch(e){
    res.status(500).json({error:e.message});
  }
});
adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get('/admin/analytics', admin , async(req, res)=>{
try{
  const orders = await Order.find({});

  let totalEarnings= 0;

  for( let i=0; i<orders.length; i++){
    for(let j=0; j<orders[i].foods.length; j++){
       totalEarnings += orders[i].foods[j].quantity * orders[i].foods[j].food.price;
    }
  }
 let fastingEarnings = await fetchCategoryFood('Fasting');
 let feastEarnings = await fetchCategoryFood('feast');
 let HotDrinksEarnings = await fetchCategoryFood('Hot Drinks');
 let SoftDrinksEarnings = await fetchCategoryFood('Soft Drinks');
 let BuffetEarnings = await fetchCategoryFood('Buffet');

 let earnings ={
  totalEarnings,
  fastingEarnings,
  feastEarnings,
  HotDrinksEarnings,
  SoftDrinksEarnings,
  BuffetEarnings,
 };

 res.json(earnings);

}catch(e){
  res.status(500).json({error:e.message});
}

});

async function fetchCategoryFood(category){
  let earnings =0;
  let categoryOrders = await Order.find({
    "foods.food.category": category,
  });
  for( let i=0; i<categoryOrders.length; i++){
    for(let j=0; j<categoryOrders[i].foods.length; j++){
      earnings += categoryOrders[i].foods[j].quantity * categoryOrders[i].foods[j].food.price;
    }
  }

  return earnings;
} ;


module.exports = adminRouter;

