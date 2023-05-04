const mongoose= require('mongoose');
const {FoodSchema} = require("./food");
const { FoodSchemaGojo } = require('./food_gojo');

const userSchema=mongoose.Schema({
    firstName:{
        require:true,
        type:String,
        trim:true,

    },
    lastName:{
        require:true,
        type:String,
        trim:true,

    },
    email:{
        require:true,
        type:String,
        trim:true,

    },
    phoneNumber:{
        required:true,
        type:String,
        trim:true,
    },
    address:{
        require:true,
        type:String,
        default:'',

    },
    type:{
        type:String,
        default:"User",
    },
    cart:[
        {
            food:FoodSchema,
            food:FoodSchemaGojo,
            quantity:{
                type:Number,
                
            }
        },
    
    ]

});

const User= mongoose.model("User",userSchema);
module.exports=User;