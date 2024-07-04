const mongoose = require("mongoose");
const schema=mongoose.Schema; 
const loginpSchema =new schema({
    email:String,
    cid:String,
    password:String,
    type:String

});
const loginp =mongoose.model("loginp",loginpSchema);
module.exports=loginp;