import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000/api';

// Create axios instance
const api = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json'
    }
});

// Add token to requests
api.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem('token');
        if (token) {
            config.headers['x-auth-token'] = token;
        }
        return config;
    },
    (error) => {
        return Promise.reject(error);
    }
);

// Response interceptor for error handling
api.interceptors.response.use(
    (response) => response,
    (error) => {
        if (error.response?.status === 401) {
            // Clear token and redirect to login
            localStorage.removeItem('token');
            localStorage.removeItem('user');
            window.location.href = '/login';
        }
        return Promise.reject(error);
    }
);

// Auth services
export const authService = {
    register: (userData) => api.post('/auth/register', userData),
    login: (credentials) => api.post('/auth/login', credentials),
    getProfile: () => api.get('/auth/profile'),
    updateProfile: (userData) => api.put('/auth/profile', userData)
};

// Destination services
export const destinationService = {
    getAll: (filters) => api.get('/destinations', { params: filters }),
    getById: (id) => api.get(`/destinations/${id}`),
    create: (destinationData) => api.post('/destinations', destinationData),
    update: (id, destinationData) => api.put(`/destinations/${id}`, destinationData),
    delete: (id) => api.delete(`/destinations/${id}`)
};

// Story services
export const storyService = {
    getAll: () => api.get('/stories'),
    getById: (id) => api.get(`/stories/${id}`),
    create: (storyData) => api.post('/stories', storyData),
    like: (id) => api.post(`/stories/${id}/like`),
    comment: (id, commentData) => api.post(`/stories/${id}/comments`, commentData)
};

// Itinerary services
export const itineraryService = {
    getAll: () => api.get('/itineraries'),
    getById: (id) => api.get(`/itineraries/${id}`),
    create: (itineraryData) => api.post('/itineraries', itineraryData),
    update: (id, itineraryData) => api.put(`/itineraries/${id}`, itineraryData),
    delete: (id) => api.delete(`/itineraries/${id}`)
};

// Tool services
export const toolService = {
    calculateBudget: (budgetData) => api.post('/tools/budget', budgetData),
    generatePackingList: (packingData) => api.post('/tools/packing', packingData),
    savePackingList: (listData) => api.post('/tools/packing/save', listData),
    getSavedPackingLists: () => api.get('/tools/packing'),
    convertCurrency: (currencyData) => api.post('/tools/currency', currencyData),
    getWeather: (location) => api.get(`/tools/weather?location=${location}`)
};

// Newsletter service
export const newsletterService = {
    subscribe: (email) => api.post('/newsletter/subscribe', { email })
};

export default api;