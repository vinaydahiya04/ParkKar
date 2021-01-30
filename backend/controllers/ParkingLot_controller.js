const PLModel=require('../Models/ParkingLot')
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken")

const generator = require("generate-password")

const RegisterPL = async (req, res) => {
    try {
        if (!req.body.email ||
            !req.body.phone ||
            !req.body.password ||
            !req.body.name ||
            !req.body.address) {

            return res.status(400).json({
                message: "Please send all required fields.",
            });
        }

        const existingAccount = await PLModel.findOne({
            $or: [{ email: req.body.email }, { phone: req.body.phone }],
        });

        if (existingAccount) {
            return res.status(400).json({
                message: "Account with this email or phone number already exists"
            })
        }

        const salt = bcrypt.genSaltSync(10);
        const hashedPassword = bcrypt.hashSync(req.body.password, salt);
        let newUser = new UserModel({
            name: req.body.name,
            email: req.body.email,
            phone: req.body.phone,
            password: hashedPassword,
        });
        await newUser.save();

        return res.status(200).json({ message: "Registration Completed" });

    } catch (e) {
        console.log(e);
        return res.status(500).json({ message: "Internal Server Error" });
    }
}

const LoginUser = async (req, res) => {
    try {
        if (!req.body.cred || !req.body.password) {
            return res.status(400).json({ message: "Please Provide all the fields" })
        }

        let user;

        if (Number(req.body.cred)) {
            user = PLModel.findOne({ phone: Number(req.body.cred) })

        } else {
            user = PLModel.findOne({ email: req.body.cred })
        }

    } catch (e) {
        console.log(e);
        res.status(500).json({ message: "Internal server Error" })
    }
}

const completeInfo  = async (req, res) => {
    try {
        const updatedUser = await PLModel.findByIdAndUpdate(
            req.userData._id,
            req.body,
            { new: true }
        );
        res.status(200).json({ message: "User Details was updated!", data: updatedUser });

    } catch (e) {
        console.log(e);
        return res.status(500).json({ message: "Internal Server Error" });
    }
}

const getAllPL= async(req,res) => {
    try{
        const allPL=await PLModel.find({})
        res.status(200).send(allPL);
    }catch (e) {
        console.log(e);
        res.status(404).json({ message: "Internal server error" });
      }
}

const getPLbyId = async (req, res) => {
    try {
      let PL = await PLModel.findOne({ _id: req.params.id })
      
      res.status(200).send(PL);
    } catch (e) {
      console.log(e);
      res.status(404).json({ message: "Internal server error" });
    }
  };

  module.exports={
      getAllPL,
      getPLbyId,
      RegisterPL,
      LoginUser,
      completeInfo
  }