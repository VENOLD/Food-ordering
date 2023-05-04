const mongoose= require('mongoose');
const { FoodSchema } = require('./food');

const orderSchema = mongoose.Schema({

      foods:[
        {
            food: FoodSchema,
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

const Order = mongoose.model('Order', orderSchema);

module.exports= Order;