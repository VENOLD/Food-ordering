const mongoose= require('mongoose');

const admin2Schema=mongoose.Schema({
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
        default:"admin2",
    },

});

const admin= mongoose.model("cashier-Gojo",admin2Schema);
module.exports=admin;