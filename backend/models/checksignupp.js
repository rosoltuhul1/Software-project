const mongoose = require("mongoose");
const schema=mongoose.Schema; 
const checkSignuppSchema =new schema({
    id:String,
    type:String

});
const checkSignupp =mongoose.model("checkSignupp",checkSignuppSchema);
module.exports=checkSignupp;