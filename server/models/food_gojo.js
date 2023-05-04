const mongoose= require('mongoose');
const ratingSchema = require('./rating');
const FoodSchemaGojo=mongoose.Schema({
  name:{
    type:String,
    required:true,
    trim:true,
  },
  description:{
    type:String,
    required:true,
    trim:true,
  },
  images:[
    {
        type:String,
         required:true,
    },
  ],
  quantity:{
        type:Number,
        required:true,
  },
  price:{
        type:Number,
        requird:true,
  },
  
   vat:{
    type:Number,
    requird:true,
   },
  category:{
        type:String,
        required:true,
  },
  
  ratings:[ratingSchema],


});

const FoodGojo =mongoose.model('Food-Gojo',FoodSchemaGojo);
module.exports ={ FoodGojo, FoodSchemaGojo };
