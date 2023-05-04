const express = require('express');
const userRouter=  express.Router(); 

const auth=require('../middlewares/auth');
const { Food } = require('../models/food');
const { FoodGojo } = require('../models/food_gojo');
const Order = require('../models/order');
const OrderGojo=require('../models/order_gojo');
const User = require('../models/user');
userRouter.post('/api/add-to-cart',auth, async(req,res)=>{
    try{
     const {id}= req.body;
     const food = await Food.findById(id);
     let user= await User.findById(req.user);

     if(user.cart.lengh == 0){
        user.cart.push({food, quantity: 1});
     }
     else{
        let isFoodFound= false;
        for(let i=0; i<user.cart.length; i++){
          if(user.cart[i].food._id.equals(food._id)){
            isFoodFound= true;
          }  
        }
        if(isFoodFound){
            let fooddd= user.cart.find((foodd)=>
            foodd.food._id.equals(food._id)
            );
            fooddd.quantity +=1;
        }
        else{
            user.cart.push({food, quantity: 1});
        }
     }
     user = await user.save();
     res.json(user);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
} );

userRouter.post('/api/add-to-cart-gojo',auth, async(req,res)=>{
  try{
   const {id}= req.body;
   const food = await FoodGojo.findById(id);
   let user= await User.findById(req.user);

   if(user.cart.lengh == 0){
      user.cart.push({food, quantity: 1});
   }
   else{
      let isFoodFound= false;
      for(let i=0; i<user.cart.length; i++){
        if(user.cart[i].food._id.equals(food._id)){
          isFoodFound= true;
        }  
      }
      if(isFoodFound){
          let fooddd= user.cart.find((foodd)=>
          foodd.food._id.equals(food._id)
          );
          fooddd.quantity +=1;
      }
      else{
          user.cart.push({food, quantity: 1});
      }
   }
   user = await user.save();
   res.json(user);
  }
  catch(e){
      res.status(500).json({error: e.message});
  }
} );

userRouter.delete('/api/remove-from-cart/:id',auth, async(req,res)=>{
  try{
   const {id}= req.params;
   const food = await Food.findById(id);
   let user= await User.findById(req.user);
      for(let i=0; i<user.cart.length; i++){
        if(user.cart[i].food._id.equals(food._id)){
          if(user.cart[i].quantity==1){
            user.cart.splice(i,1);
          } else{
            user.cart[i].quantity -=1;
          } 
        }  
      }
   user = await user.save();
   res.json(user);
  }
  catch(e){
      res.status(500).json({error: e.message});
  }
} );
userRouter.delete('/api/remove-from-cart-gojo/:id',auth, async(req,res)=>{
  try{
   const {id}= req.params;
   const food = await FoodGojo.findById(id);
   let user= await User.findById(req.user);

      for(let i=0; i<user.cart.length; i++){
        if(user.cart[i].food._id.equals(food._id)){
          if(user.cart[i].quantity==1){
            user.cart.splice(i,1);
          } else{
            user.cart[i].quantity -=1;
          } 
        }  
      }
   user = await user.save();
   res.json(user);
  }
  catch(e){
      res.status(500).json({error: e.message});
  }
} );


// save user address
userRouter.post('/api/save-user-address', auth, async(req, res)=>{

   try{

    const {address} = req.body;
    let user = await User.findById(req.user);
    user.address= address;
    user= await user.save();
    res.json(user);

   }catch(e){
    res.status(500).json({error: e.message});
   }

});
userRouter.post('/api/save-user-address-gojo', auth, async(req, res)=>{

  try{

   const {address} = req.body;
   let user = await User.findById(req.user);
   user.address= address;
   user= await user.save();
   res.json(user);

  }catch(e){
   res.status(500).json({error: e.message});
  }

});

// order food/ drinks

userRouter.post('/api/order', auth, async(req, res)=>{
  try{

   const {cart,totalPrice} = req.body;
   let foods=[];

   for(let i=0; i<cart.length; i++){
   let food= await Food.findById(cart[i].food._id);

   if(food.quantity >=cart[i].quantity){
    food.quantity -= cart[i].quantity;
    foods.push({food, quantity:cart[i].quantity});
    await food.save(); 
  }
  else{
    return res.status(400).json({msg: `${food.name} is not available! `});
  }

   }
   let user= await User.findById(req.user);
   user.cart =[];
   user = await user.save();

   let order = new Order({
    foods,
    totalPrice,
    userId: req.user,
    orderedAt: new Date().getTime(),

});
order= await order.save()
   res.json(order);
  }catch(e){
   res.status(500).json({error: e.message});
  }

});
userRouter.post('/api/order-gojo', auth, async(req, res)=>{
  try{
   const {cart,totalPrice} = req.body;
   let foods=[];
   for(let i=0; i<cart.length; i++){
   let food= await FoodGojo.findById(cart[i].food._id);

   if(food.quantity >=cart[i].quantity){
      food.quantity -= cart[i].quantity;
      foods.push({food, quantity:cart[i].quantity});
      await food.save(); 
    }
  else{
    return res.status(400).json({msg: `${food.name} is not available! `});
  }
   }

   let user= await User.findById(req.user);
   user.cart =[];
   user = await user.save();

   let order = new OrderGojo({
    foods,
    totalPrice,
    userId: req.user,
    orderedAt: new Date().getTime(),

});
order= await order.save()
   res.json(order);

  }catch(e){
   res.status(500).json({error: e.message});
  }

});

userRouter.get('/api/orders/me', auth, async(req, res)=>{
 try{
  const orders =await Order.find({userId:req.user});
  res.json(orders);

 }catch(e){
  res.status(500).json({error: e.message});
 }

});
userRouter.get('/api/orders/me-gojo', auth, async(req, res)=>{
  try{
   const orders =await OrderGojo.find({userId:req.user});
   res.json(orders);
 
  }catch(e){
   res.status(500).json({error: e.message});
  }
 
 })


module.exports = userRouter;

