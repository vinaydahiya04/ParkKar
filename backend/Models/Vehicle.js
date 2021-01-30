const mongoose = require('mongoose');

const VehicleSchema = new mongoose.Schema({
    company: {
        type: String,
        required: true
    },
    model: {
        type: String,
        required: true
    },
    seater: {
        type: Number,
        required: true
    },


})

module.exports = mongoose.model('Vehicle', VehicleSchema);