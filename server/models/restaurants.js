const mongoose= require('mongoose');

const RestaurantSchema=mongoose.Schema({
    name:{
        require:true,
        type:String,
        trim:true,

}});

const Restaurant= mongoose.model("Restaurant",RestaurantSchema);
module.exports=Restaurant;
