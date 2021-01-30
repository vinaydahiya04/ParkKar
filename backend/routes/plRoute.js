const express = require('express');
const {  getAllPL,
    getPLbyId,
    RegisterPL,
    LoginUser,
    completeInfo,
    rating } = require('../controllers/ParkingLot_controller')

const UserAuthMiddleware = require('../middlewares/pl_auth')

const router = express.Router();


router.post('/register',RegisterPL);
router.post('/login',LoginUser);
router.post('/rating/:id',rating);
router.put('/',UserAuthMiddleware,completeInfo);
router.get('/all',getAllPL);

router.get('/info/:id',getPLbyId);


module.exports = router;