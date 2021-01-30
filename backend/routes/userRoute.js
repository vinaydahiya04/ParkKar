const express = require('express');
const { RecoverUser,
    GoogleAuth,
    LoginUser,
    UpdateUser,
    RegisterUser,
    addVehicleToProfile } = require('../controllers/User')

const UserAuthMiddleware = require('../middlewares/user_auth')

const router = express.Router();


router.post('/add_vehicle', addVehicleToProfile);
router.post("/login", LoginUser);
router.post("/signup", RegisterUser);
router.post("/google", GoogleAuth);
router.put("/update", UserAuthMiddleware, UpdateUser);
router.post('/recover', RecoverUser)