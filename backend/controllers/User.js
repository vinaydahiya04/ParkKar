const UserModel = require('../models/User');
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");


const RegisterUser = async (req, res) => {
    try {
        if (!req.body.email ||
            !req.body.phone ||
            !req.body.password ||
            !req.body.name) {

            return res.status(400).json({
                message: "Please send all required fields.",
            });

        }

        const existingAccount = await UserModel.findOne({
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

    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Internal Server Error" });
    }
}

const updateUser = async (req, res) => {
    try {
        const updatedUser = await UserModel.findByIdAndUpdate(
            req.userData._id,
            req.body,
            { new: true }
        );
        res.status(200).json({ message: "User Details was updated!", data: updatedUser });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Internal Server Error" });
    }

};

const LoginUser = async (req, res) => {
    try {
        if (!req.body.cred || !req.body.password) {
            return res.status(400).json({ message: "Please Provide all the fields" })
        }

        let user;

        if (Number(req.body.cred)) {
            user = UserModel.findOne({ phone: Number(req.body.cred) })

        } else {
            user = UserModel.findOne({ email: req.body.cred })
        }



    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal server Error" })
    }
}