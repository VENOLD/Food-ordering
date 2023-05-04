const mongoose= require('mongoose');
const ratingSchema = require('./rating');

const FoodSchema=mongoose.Schema({
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
  isAvailable:{
    type:Number,
    required:false,
    default:0,
},
  
  ratings:[ratingSchema],


});

const Food =mongoose.model('Food-mezenagna',FoodSchema);
module.exports ={ Food, FoodSchema };
