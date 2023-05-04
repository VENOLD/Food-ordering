const mongoose= require('mongoose');
const { FoodSchemaGojo } = require('./food_gojo');

const orderSchemaGojo = mongoose.Schema({

      foods:[
        {
            food: FoodSchemaGojo,
            quantity:{
                type:Number,
                required:true,
            },
        },
      ],
      totalPrice:{
        type:Number,
        required:true,
      },
      userId:{
        required:true,
        type:String,
      },
      orderedAt:{
        type:Number,
        required:true,
      },
      status:{
        type:Number,
        default:0,
      },

});

const OrderGojo = mongoose.model('Order-Gojo', orderSchemaGojo);

module.exports= OrderGojo;