const jwt= require('jsonwebtoken');
const AdminGojo = require('../models/admin2');

const admin = async (req, res, next)=>{
    try{
        const token =req.header("x-auth-token");
        if(!token)
        return res.status(401).json({msg:"No authorization token,access denied"});
    
        const verified =jwt.verify(token,'passwordKey');
        if(!verified) return res.status(401).json({msg:"Token Verification faild, authorization denied,"});
        
        const admin =await AdminGojo.findById(verified.id);  
        if(admin.type=="user" || admin.type=="seller"){
            return res.status(401).json({msg:"You Are Not An Admin!"});
        }  
        req.admin=verified.id;
        req.token=token;
        next();
    }catch(err){
            res.status(500).json({error:err.message});
        }
};

module.exports = admin;

