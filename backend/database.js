const mongoose = require("mongoose");
mongoose
//mongodb+srv://rosol:<password>@atlascluster.lgxoufm.mongodb.net/
	.connect(
        "mongodb+srv://rosol:roro123@atlascluster.lgxoufm.mongodb.net/?retryWrites=true&w=majority")
	.then(() => {
		console.log("connected successfully");
	})
	.catch((error) => {
		console.log("error with connecting with the DB ", error);
	});

module.exports=mongoose;