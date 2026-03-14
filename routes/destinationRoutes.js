const express = require('express');
const router = express.Router();
const destinationController = require('../controllers/destinationController');
const auth = require('../middleware/auth');

// Public routes
router.get('/', destinationController.getAllDestinations);
router.get('/:id', destinationController.getDestination);

// Protected routes (admin only in production)
router.post('/', auth, destinationController.createDestination);
router.put('/:id', auth, destinationController.updateDestination);
router.delete('/:id', auth, destinationController.deleteDestination);

module.exports = router;