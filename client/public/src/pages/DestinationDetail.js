import React from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useQuery, useMutation } from '@tanstack/react-query';
import { destinationService, itineraryService } from '../services/api';
import { 
    FaMapMarkerAlt, 
    FaCalendar, 
    FaLanguage, 
    FaMoneyBillWave,
    FaStar,
    FaCalendarPlus,
    FaCalculator
} from 'react-icons/fa';
import toast from 'react-hot-toast';

const DestinationDetail = () => {
    const { id } = useParams();
    const navigate = useNavigate();
    
    // Fetch destination details
    const { data, isLoading, error } = useQuery({
        queryKey: ['destination', id],
        queryFn: () => destinationService.getById(id)
    });
    
    // Mutation for adding to itinerary
    const addToItineraryMutation = useMutation({
        mutationFn: () => itineraryService.create({
            destination: data?.data?.name,
            name: `Trip to ${data?.data?.name}`
        }),
        onSuccess: () => {
            toast.success('Added to itinerary!');
            navigate('/itinerary');
        },
        onError: () => {
            toast.error('Failed to add to itinerary');
        }
    });
    
    const destination = data?.data;
    
    if (isLoading) return <div>Loading...</div>;
    if (error) return <div>Error loading destination</div>;
    if (!destination) return <div>Destination not found</div>;
    
    return (
        <div className="destination-detail-page">
            <div className="container">
                {/* Hero Section */}
                <div className="destination-hero">
                    <img src={destination.image_url} alt={destination.name} />
                    <div className="hero-content">
                        <h1>{destination.name}, {destination.country}</h1>
                        <p>{destination.description}</p>
                    </div>
                </div>
                
                {/* Quick Info */}
                <div className="quick-info-grid">
                    <div className="info-card">
                        <FaCalendar />
                        <h4>Best Time to Visit</h4>
                        <p>{destination.best_time}</p>
                    </div>
                    <div className="info-card">
                        <FaLanguage />
                        <h4>Language</h4>
                        <p>{destination.language}</p>
                    </div>
                    <div className="info-card">
                        <FaMoneyBillWave />
                        <h4>Currency</h4>
                        <p>{destination.currency}</p>
                    </div>
                    <div className="info-card">
                        <FaStar />
                        <h4>Cost Range</h4>
                        <p>{destination.cost_range}</p>
                    </div>
                </div>
                
                {/* Main Content */}
                <div className="detail-content">
                    <div className="content-section">
                        <h2>Top Highlights</h2>
                        <ul className="highlight-list">
                            {destination.highlights?.map((highlight, index) => (
                                <li key={index}>{highlight}</li>
                            ))}
                        </ul>
                    </div>
                    
                    <div className="content-section">
                        <h2>Travel Tips</h2>
                        <ul className="tip-list">
                            {destination.tips?.map((tip, index) => (
                                <li key={index}>{tip}</li>
                            ))}
                        </ul>
                    </div>
                    
                    <div className="content-section">
                        <h2>Recommended Stay</h2>
                        <p>{destination.recommended_days} days</p>
                    </div>
                </div>
                
                {/* Action Buttons */}
                <div className="action-buttons">
                    <button 
                        className="btn btn-primary"
                        onClick={() => addToItineraryMutation.mutate()}
                        disabled={addToItineraryMutation.isLoading}
                    >
                        <FaCalendarPlus /> Add to Itinerary
                    </button>
                    <button 
                        className="btn btn-accent"
                        onClick={() => navigate('/tools/budget')}
                    >
                        <FaCalculator /> Calculate Budget
                    </button>
                </div>
            </div>
        </div>
    );
};

export default DestinationDetail;