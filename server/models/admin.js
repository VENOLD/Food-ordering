const mongoose= require('mongoose');

const adminSchema=mongoose.Schema({
    name:{
        require:true,
        type:String,
        trim:true,

    },
    password:{
        type:String,
        required:true,
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
        default:"admin",
    },

});

const admin= mongoose.model("cashier-mezenagna",adminSchema);
module.exports=admin;