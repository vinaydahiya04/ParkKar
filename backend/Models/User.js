const mongoose = require('mongoose')
const Schema = mongoose.Schema;
const UserSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Please provide a name']
    },
    email: {
        type: String,
        required: true,
        unique: true,
        match: [
            /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
            'Please add a valid email'
        ],
    },
    phone: {
        type: Number
    },
    password: {
        type: String
    },
    googleId: {
        type: String
    },
    facebookId: {
        type: String
    },
    vehicles: {
        type: [
            {
                vehicle: { type: Schema.Types.ObjectId, ref: 'Vehicle' }

            }
        ],
    },


})

module.exports = mongoose.model('User', UserSchema);