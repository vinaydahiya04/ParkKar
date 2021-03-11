const mongoose = require('mongoose')

const ParkingLotSchema = new mongoose.Schema({
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
        type: String,

    },
    // googleId: {
    //     type: String
    // },
    // facebookId: {
    //     type: String
    // }
    address: {
        type: String,

    },
    latitude: {
        type: Number
    },
    longitude: {
        type: Number
    },
    image: {
        type:
            [
                {
                    type: String, default: "https://www.claconnect.com/-/media/cla-image-repository/general/casual_family_and_recreation/surface-lot-car-parking.jpg"
                }
            ]
    },
    charges: {
        type: Number,

    },
    startingTime: {
        type: String
    },
    endingTime: {
        type: String
    },
    FourSpotsLeft: {
        type: Number,
        default: 0
    },
    TwoSpotsLeft: {
        type: Number,
        default: 0
    },
    MapApiData: {
        type: String
    },
    averageRating: {
        type: Number,
        min: [0, 'Rating must be at least 0'],
        max: [5, 'Rating must can not be more than 5'],
        default: 0
    },
    averageCount: {
        type: Number,
        default: 0
    }

})

module.exports = mongoose.model('ParkingLot', ParkingLotSchema);

