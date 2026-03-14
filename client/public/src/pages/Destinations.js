import React, { useState, useEffect } from 'react';
import { useQuery } from '@tanstack/react-query';
import DestinationCard from '../components/DestinationCard';
import { destinationService } from '../services/api';
import { FaSearch, FaFilter } from 'react-icons/fa';
import toast from 'react-hot-toast';

const Destinations = () => {
    const [filters, setFilters] = useState({
        type: '',
        search: ''
    });

    // Fetch destinations using React Query
    const { data, isLoading, error, refetch } = useQuery({
        queryKey: ['destinations', filters],
        queryFn: () => destinationService.getAll(filters)
    });

    const handleFilterChange = (e) => {
        const { name, value } = e.target;
        setFilters(prev => ({
            ...prev,
            [name]: value
        }));
    };

    const handleSearch = (e) => {
        e.preventDefault();
        refetch();
    };

    if (error) {
        toast.error('Failed to load destinations');
        return <div>Error loading destinations</div>;
    }

    return (
        <div className="destinations-page">
            <div className="container">
                <h1 className="section-title">Explore Destinations</h1>
                
                {/* Filters and Search */}
                <div className="filters-section">
                    <form onSubmit={handleSearch} className="search-box">
                        <input
                            type="text"
                            name="search"
                            placeholder="Search destinations..."
                            value={filters.search}
                            onChange={handleFilterChange}
                        />
                        <button type="submit">
                            <FaSearch />
                        </button>
                    </form>
                    
                    <div className="filter-buttons">
                        <button 
                            className={`filter-btn ${!filters.type ? 'active' : ''}`}
                            onClick={() => setFilters({...filters, type: ''})}
                        >
                            All
                        </button>
                        {['beach', 'city', 'hiking', 'adventure', 'cultural', 'eco', 'food'].map(type => (
                            <button
                                key={type}
                                className={`filter-btn ${filters.type === type ? 'active' : ''}`}
                                onClick={() => setFilters({...filters, type})}
                            >
                                {type.charAt(0).toUpperCase() + type.slice(1)}
                            </button>
                        ))}
                    </div>
                </div>
                
                {/* Loading State */}
                {isLoading ? (
                    <div className="loading-spinner">
                        <div className="spinner"></div>
                        <p>Loading destinations...</p>
                    </div>
                ) : (
                    <>
                        {/* Results Count */}
                        <div className="results-count">
                            <p>Found {data?.data?.count || 0} destinations</p>
                        </div>
                        
                        {/* Destinations Grid */}
                        <div className="destination-grid">
                            {data?.data?.data?.map(destination => (
                                <DestinationCard 
                                    key={destination.id} 
                                    destination={destination} 
                                />
                            ))}
                        </div>
                        
                        {/* No Results */}
                        {data?.data?.count === 0 && (
                            <div className="no-results">
                                <h3>No destinations found</h3>
                                <p>Try different search terms or filters</p>
                            </div>
                        )}
                    </>
                )}
            </div>
        </div>
    );
};

export default Destinations;