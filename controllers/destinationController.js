const Destination = require('../models/Destination');

exports.getAllDestinations = async (req, res) => {
    try {
        const { type, search } = req.query;
        const filters = {};
        
        if (type) filters.type = type;
        if (search) filters.search = search;
        
        const destinations = await Destination.findAll(filters);
        res.json({
            success: true,
            count: destinations.length,
            data: destinations
        });
    } catch (error) {
        console.error('Error fetching destinations:', error);
        res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};

exports.getDestination = async (req, res) => {
    try {
        const destination = await Destination.findById(req.params.id);
        
        if (!destination) {
            return res.status(404).json({
                success: false,
                message: 'Destination not found'
            });
        }
        
        res.json({
            success: true,
            data: destination
        });
    } catch (error) {
        console.error('Error fetching destination:', error);
        res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};

exports.createDestination = async (req, res) => {
    try {
        const destinationId = await Destination.create(req.body);
        
        res.status(201).json({
            success: true,
            message: 'Destination created successfully',
            data: { id: destinationId }
        });
    } catch (error) {
        console.error('Error creating destination:', error);
        res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};

// Add more controller methods as needed...