import React from 'react';
import { Link } from 'react-router-dom';
import { FaMapMarkerAlt, FaCalendar, FaWallet, FaClock } from 'react-icons/fa';

const DestinationCard = ({ destination }) => {
    return (
        <div className="destination-card">
            <div className="destination-badge">{destination.badge}</div>
            <img 
                src={destination.image_url} 
                alt={`${destination.name}, ${destination.country}`}
                className="destination-img"
            />
            <div className="destination-info">
                <h3>{destination.name}</h3>
                <p className="location">
                    <FaMapMarkerAlt /> {destination.country}
                </p>
                <p>{destination.description}</p>
                <div className="destination-meta">
                    <span><FaCalendar /> Best in {destination.season}</span>
                    <span><FaWallet /> {destination.cost_range}</span>
                    <span><FaClock /> {destination.recommended_days} days</span>
                </div>
                <Link 
                    to={`/destinations/${destination.id}`}
                    className="btn btn-primary"
                >
                    View Details
                </Link>
            </div>
        </div>
    );
};

export default DestinationCard;