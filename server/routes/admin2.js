const express = require('express');
const adminRouter2=  express.Router();
const admin =require('../middlewares/admin2');
const AdminGojo=require('../models/admin2');
const jwt= require('jsonwebtoken');
const bcryptjs = require("bcryptjs");
const { FoodGojo } = require('../models/food_gojo');
const OrderGojo = require('../models/order_gojo');
//add food 
adminRouter2.post("/api/signup-admin2",async function(req,res){
    try{
      const {name,phoneNumber,password}= req.body;
     
      const existingUser= await AdminGojo.findOne({phoneNumber});
      
      if(existingUser){
            
       return res.status(400).json({msg:" Admin With Same phone \n number Already Exists!\n Please Sign In"});
      
       } 
       const hashedPassword = await bcryptjs.hash(password, 6);
    
     let admin =new AdminGojo({
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
    adminRouter2.post('/api/signin-admin2', async(req,res)=>{
        try{
          const {phoneNumber, password} = req.body;
          const admin=await AdminGojo.findOne({phoneNumber});
          if(!admin){
            return res.status(400).json({msg:"Admin With This phone number Does Not Exist in Gojo!"});
          }
          const isMatch = await bcryptjs.compare(password, admin.password);
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
      adminRouter2.post("/tokenIsValid", async(req,res)=>{
        try{
          const token =req.header('x-auth-token');
          if(!token) return res.json(false);
          const verified =jwt.verify(token,'passwordKey');
          if(!verified) return res.json(false);
           
          const admin =await AdminGojo.findById(verified.id);
          if(!admin) return res.json(false);
          res.json(true);
      
        }catch(e){
          res.status(500).json({error:e.message}); 
         
      
        }
      });
      //get user data
      adminRouter2.get("/",admin,async(req,res)=>{
        const admin=await AdminGojo.findById(req.admin);
        res.json({...admin._doc,token:req.token});
      })
     
    adminRouter2.post('/admin/add-food2',admin, async(req,res)=>{
        try{
         const {name,description,images,quantity,price,category,vat }=req.body;
         let food = new FoodGojo ({
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
    
    
    adminRouter2.get('/admin/get-food2',admin, async(req,res)=>{
      try{
        const food =await FoodGojo.find({});
        res.json(food);
    
      }catch(e){
        res.status(500).json({error:e.message});
      }
    });
    //delete the foods/drinks
    
    adminRouter2.post('/admin/delete-food2',admin, async(req, res)=>{
      try{
      const {id}=req.body;
      let food=await FoodGojo.findByIdAndDelete(id);
    res.json(food); 
      }catch(e){
        res.status(500).json({error:e.message});
      }
    });
    // update the quantity
    
    adminRouter2.post('/admin/change-order-status2',admin, async(req, res)=>{
      try{
      const {id, status}=req.body;
      let order=await OrderGojo.findById(id);
      order.status = status;
      order= await order.save();
    res.json(order);
      }catch(e){
        res.status(500).json({error:e.message});
      }
    });
    adminRouter2.get("/admin/get-orders2", admin, async (req, res) => {
      try {
        const orders = await OrderGojo.find({});
        res.json(orders);
      } catch (e) {
        res.status(500).json({ error: e.message });
      }
    });
    
    adminRouter2.get('/admin/analytics2', admin , async(req, res)=>{
    try{
      const orders = await OrderGojo.find({});
    
      let totalEarnings= 0;
    
      for( let i=0; i<orders.length; i++){
        for(let j=0; j<orders[i].foods.length; j++){
           totalEarnings += orders[i].foods[j].quantity * orders[i].foods[j].food.price;
        }
      }
     let fastingEarnings = await fetchCategoryFood('የፆም-Fasting');
     let feastEarnings = await fetchCategoryFood('የፍስክ-feast');
     let HotDrinksEarnings = await fetchCategoryFood('ትኩስ መጠጦች-Hot Drinks');
     let SoftDrinksEarnings = await fetchCategoryFood('ለስላሳ መጠጦች-Soft Drinks');
     let BuffetEarnings = await fetchCategoryFood('ቡፌ-Buffet');
    
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
      let categoryOrders = await OrderGojo.find({
        "foods.food.category": category,
      });
      for( let i=0; i<categoryOrders.length; i++){
        for(let j=0; j<categoryOrders[i].foods.length; j++){
          earnings += categoryOrders[i].foods[j].quantity * categoryOrders[i].foods[j].food.price;
        }
      }
    
      return earnings;
    } ;
    


module.exports = adminRouter2;

