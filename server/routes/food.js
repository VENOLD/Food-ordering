const express = require('express');
const foodRouter=  express.Router();
const auth = require('../middlewares/auth');
const admin= require('../middlewares/admin');
const {Food}=require("../models/food");
const { FoodGojo } = require('../models/food_gojo');

foodRouter.get('/api/food/',auth, async(req,res)=>{
    try{
      const food =await Food.find({category: req.query.category,isAvailable: req.query.isAvailable==1});
      res.json(food);
    }catch(e){
      res.status(500).json({error:e.message});
    }
  });
  foodRouter.get('/api/food/gojo/',auth, async(req,res)=>{
    try{
      const food =await FoodGojo.find({category: req.query.category});
      res.json(food);
    }catch(e){
      res.status(500).json({error:e.message});
    }
  });
  foodRouter.get('/api/food/search/:name',auth, async(req,res)=>{
    try{
        
      const food = await Food.find({
        name:{$regex: req.params.name, $options:"i"},
      })
      res.json(food);
  
    }catch(e){
      res.status(500).json({error:e.message});
    }
  });
  foodRouter.get('/api/food/searching/:_id',admin, async(req,res)=>{
    try{
        
      const food = await Food.find({
        id:{$regex: req.params.id, $options:"i"},
      })
      res.json(food);
  
    }catch(e){
      res.status(500).json({error:e.message});
    }
  });

  foodRouter.post('/api/rate-food',auth, async(req, res)=>{
   try{
    const { id, rating}= req.body;
    let food= await Food.findById(id);

    for(let i=0; i<food.ratings.length; i++){
    if(food.ratings[i].userId==req.user){
     food.ratings.splice(i,1);
     break;
    }
  }
  const ratingSchema={
    userId: req.user,
    rating,
  };
  food.ratings.push(ratingSchema);
  food = await food.save();
  res.json(food);
  }catch(e){
    res.status(500).json({error: e.message});
  }

 }) ;
foodRouter.get('/api/sale-of-day', auth, async(req, res)=>{
  try{

let food = await Food.find({isAvailable: req.query.isAvailable==1});

food = food.sort((a,b)=>{
  let aSum=0;
  let bSum=0;
  for(let i=0; i<a.ratings.length; i++){
    aSum+= a.ratings[i].rating;
  }
  for(let i=0; i<b.ratings.length; i++){
    bSum+= b.ratings[i].rating;
  }
  return aSum < bSum ? 1: -1 ;


});
res.json(food[0]);

  }catch(e){
    res.status(500).json({error: e.message});
  }

})



module.exports = foodRouter;
