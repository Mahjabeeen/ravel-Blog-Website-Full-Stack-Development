const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
// Load environment variables
dotenv.config();
// Initialize express
const app = express();
// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
// Basic route
app.get('/', (req, res) => {
    res.json({ 
        message: 'Travel Blog API is running!',
        endpoints: {
            destinations: '/api/destinations',
            stories: '/api/stories'
        }
    });
});
// Destinations API
app.get('/api/destinations', (req, res) => {
    res.json({
        success: true,
        count: 2,
        data: [
            {
                id: 1,
                name: 'Santorini',
                country: 'Greece',
                description: 'Famous for its dramatic views and stunning sunsets.',
                image_url: 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-4.0.3&auto=format&fit=crop&w=686&q=80',
                type: 'beach',
                badge: 'Popular',
                season: 'Summer',
                recommended_days: 7,
                cost_range: '$$$'
            },
            {
                id: 2,
                name: 'Kyoto',
                country: 'Japan',
                description: 'Known for its classical Buddhist temples and gardens.',
                image_url: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80',
                type: 'city',
                badge: 'Cultural',
                season: 'Spring',
                recommended_days: 10,
                cost_range: '$$'
            }
        ]
    });
});
// Stories API
app.get('/api/stories', (req, res) => {
    res.json({
        success: true,
        count: 2,
        data: [
            {
                id: 1,
                title: 'Hiking the Swiss Alps',
                author: 'Sarah Johnson',
                excerpt: 'An unforgettable two-week trek through the Swiss Alps.',
                image_url: 'https://images.unsplash.com/photo-1551632811-561732d1e306?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80',
                category: 'Adventure',
                read_time: '8 min read'
            },
            {
                id: 2,
                title: 'Bangkok Street Food Tour',
                author: 'Michael Chen',
                excerpt: 'Exploring the vibrant street food scene in Bangkok.',
                image_url: 'https://images.unsplash.com/photo-1534008897995-27a23e859048?ixlib=rb-4.0.3&auto=format&fit=crop&w=1174&q=80',
                category: 'Food',
                read_time: '6 min read'
            }
        ]
    });
});
// Budget calculator endpoint
app.post('/api/tools/budget', (req, res) => {
    const { destination, days, travelers, accommodation_type, meal_budget, transport_type } = req.body;
    // Simple calculation
    const accommodationCost = { budget: 40, mid: 95, luxury: 200 }[accommodation_type] || 95;
    const mealCost = { budget: 20, mid: 40, luxury: 80 }[meal_budget] || 40;
    const transportCost = { budget: 10, mid: 40, luxury: 100 }[transport_type] || 40;
    const totalAccommodation = accommodationCost * days * travelers;
    const totalMeals = mealCost * days * travelers;
    const totalTransport = transportCost * days * travelers;
    const totalActivities = 50 * days * travelers;
    const totalBudget = totalAccommodation + totalMeals + totalTransport + totalActivities;
    res.json({
        success: true,
        data: {
            destination,
            days,
            travelers,
            accommodation_cost: totalAccommodation,
            food_cost: totalMeals,
            transport_cost: totalTransport,
            activities_cost: totalActivities,
            total_budget: totalBudget,
            per_person: totalBudget / travelers
        }
    });
});
// 404 handler
app.use((req, res) => {
    res.status(404).json({
        success: false,
        message: 'Endpoint not found'
    });
});
// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({
        success: false,
        message: 'Something went wrong!'
    });
});
// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`✅ Server running on port ${PORT}`);
    console.log(`🌐 Open http://localhost:${PORT} in your browser`);
    console.log(`📚 API available at http://localhost:${PORT}/api/destinations`);
});
