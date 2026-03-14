import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Toaster } from 'react-hot-toast';
import { HelmetProvider } from 'react-helmet-async';

// Components
import Navbar from './components/Navbar';
import Footer from './components/Footer';

// Pages
import Home from './pages/Home';
import Destinations from './pages/Destinations';
import DestinationDetail from './pages/DestinationDetail';
import Stories from './pages/Stories';
import StoryDetail from './pages/StoryDetail';
import Login from './pages/Login';
import Register from './pages/Register';
import Profile from './pages/Profile';
import Itinerary from './pages/Itinerary';
import Tools from './pages/Tools';
import BudgetCalculator from './components/Tools/BudgetCalculator';
import PackingList from './components/Tools/PackingList';
import ItineraryPlanner from './components/Tools/ItineraryPlanner';

// Context
import { AuthProvider } from './context/AuthContext';

// Create a client
const queryClient = new QueryClient();

function App() {
    return (
        <HelmetProvider>
            <QueryClientProvider client={queryClient}>
                <AuthProvider>
                    <Router>
                        <div className="App">
                            <Navbar />
                            <main>
                                <Routes>
                                    <Route path="/" element={<Home />} />
                                    <Route path="/destinations" element={<Destinations />} />
                                    <Route path="/destinations/:id" element={<DestinationDetail />} />
                                    <Route path="/stories" element={<Stories />} />
                                    <Route path="/stories/:id" element={<StoryDetail />} />
                                    <Route path="/login" element={<Login />} />
                                    <Route path="/register" element={<Register />} />
                                    <Route path="/profile" element={<Profile />} />
                                    <Route path="/itinerary" element={<Itinerary />} />
                                    <Route path="/tools" element={<Tools />} />
                                    <Route path="/tools/budget" element={<BudgetCalculator />} />
                                    <Route path="/tools/packing" element={<PackingList />} />
                                    <Route path="/tools/planner" element={<ItineraryPlanner />} />
                                </Routes>
                            </main>
                            <Footer />
                            <Toaster position="top-right" />
                        </div>
                    </Router>
                </AuthProvider>
            </QueryClientProvider>
        </HelmetProvider>
    );
}

export default App;