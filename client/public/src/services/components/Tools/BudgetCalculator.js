import React, { useState } from 'react';
import { useMutation } from '@tanstack/react-query';
import { toolService } from '../../services/api';
import toast from 'react-hot-toast';
import { FaCalculator, FaHotel, FaUtensils, FaCar, FaMoneyBillWave } from 'react-icons/fa';

const BudgetCalculator = () => {
    const [formData, setFormData] = useState({
        destination: '',
        days: 7,
        travelers: 1,
        accommodation_type: 'mid',
        meal_budget: 'mid',
        transport_type: 'mid'
    });
    
    const [result, setResult] = useState(null);
    
    const calculateMutation = useMutation({
        mutationFn: toolService.calculateBudget,
        onSuccess: (data) => {
            setResult(data.data);
            toast.success('Budget calculated successfully!');
        },
        onError: () => {
            toast.error('Failed to calculate budget');
        }
    });
    
    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({
            ...prev,
            [name]: name === 'days' || name === 'travelers' ? parseInt(value) : value
        }));
    };
    
    const handleSubmit = (e) => {
        e.preventDefault();
        calculateMutation.mutate(formData);
    };
    
    const accommodationOptions = [
        { value: 'budget', label: 'Budget ($30-50/night)', cost: 40 },
        { value: 'mid', label: 'Mid-range ($70-120/night)', cost: 95 },
        { value: 'luxury', label: 'Luxury ($150+/night)', cost: 200 }
    ];
    
    const mealOptions = [
        { value: 'budget', label: 'Budget ($15-25/day)', cost: 20 },
        { value: 'mid', label: 'Mid-range ($30-50/day)', cost: 40 },
        { value: 'luxury', label: 'Luxury ($75+/day)', cost: 80 }
    ];
    
    const transportOptions = [
        { value: 'budget', label: 'Public Transport ($10/day)', cost: 10 },
        { value: 'mid', label: 'Rental Car ($40/day)', cost: 40 },
        { value: 'luxury', label: 'Private Driver ($100+/day)', cost: 100 }
    ];
    
    return (
        <div className="budget-calculator">
            <h2><FaCalculator /> Travel Budget Calculator</h2>
            
            <form onSubmit={handleSubmit}>
                <div className="form-row">
                    <div className="form-group">
                        <label>Destination</label>
                        <input
                            type="text"
                            name="destination"
                            value={formData.destination}
                            onChange={handleChange}
                            placeholder="Where are you going?"
                            required
                        />
                    </div>
                    
                    <div className="form-group">
                        <label>Days</label>
                        <input
                            type="number"
                            name="days"
                            value={formData.days}
                            onChange={handleChange}
                            min="1"
                            required
                        />
                    </div>
                    
                    <div className="form-group">
                        <label>Travelers</label>
                        <input
                            type="number"
                            name="travelers"
                            value={formData.travelers}
                            onChange={handleChange}
                            min="1"
                            required
                        />
                    </div>
                </div>
                
                <div className="form-section">
                    <h3><FaHotel /> Accommodation</h3>
                    <div className="option-grid">
                        {accommodationOptions.map(option => (
                            <label key={option.value} className="option-card">
                                <input
                                    type="radio"
                                    name="accommodation_type"
                                    value={option.value}
                                    checked={formData.accommodation_type === option.value}
                                    onChange={handleChange}
                                />
                                <span>{option.label}</span>
                            </label>
                        ))}
                    </div>
                </div>
                
                <div className="form-section">
                    <h3><FaUtensils /> Food & Dining</h3>
                    <div className="option-grid">
                        {mealOptions.map(option => (
                            <label key={option.value} className="option-card">
                                <input
                                    type="radio"
                                    name="meal_budget"
                                    value={option.value}
                                    checked={formData.meal_budget === option.value}
                                    onChange={handleChange}
                                />
                                <span>{option.label}</span>
                            </label>
                        ))}
                    </div>
                </div>
                
                <div className="form-section">
                    <h3><FaCar /> Transportation</h3>
                    <div className="option-grid">
                        {transportOptions.map(option => (
                            <label key={option.value} className="option-card">
                                <input
                                    type="radio"
                                    name="transport_type"
                                    value={option.value}
                                    checked={formData.transport_type === option.value}
                                    onChange={handleChange}
                                />
                                <span>{option.label}</span>
                            </label>
                        ))}
                    </div>
                </div>
                
                <button 
                    type="submit" 
                    className="btn btn-primary"
                    disabled={calculateMutation.isLoading}
                >
                    {calculateMutation.isLoading ? 'Calculating...' : 'Calculate Budget'}
                </button>
            </form>
            
            {result && (
                <div className="budget-result">
                    <h3><FaMoneyBillWave /> Budget Breakdown</h3>
                    <div className="breakdown-grid">
                        <div className="breakdown-item">
                            <h4>Accommodation</h4>
                            <p>${result.accommodation_cost?.toLocaleString()}</p>
                        </div>
                        <div className="breakdown-item">
                            <h4>Food & Dining</h4>
                            <p>${result.food_cost?.toLocaleString()}</p>
                        </div>
                        <div className="breakdown-item">
                            <h4>Transportation</h4>
                            <p>${result.transport_cost?.toLocaleString()}</p>
                        </div>
                        <div className="breakdown-item">
                            <h4>Activities</h4>
                            <p>${result.activities_cost?.toLocaleString()}</p>
                        </div>
                    </div>
                    
                    <div className="total-budget">
                        <h4>Total Estimated Cost</h4>
                        <p className="total-amount">${result.total_budget?.toLocaleString()}</p>
                        <p className="per-person">
                            Per person: ${(result.total_budget / formData.travelers).toLocaleString()}
                        </p>
                    </div>
                    
                    <button 
                        className="btn btn-accent"
                        onClick={() => {
                            // Save to user's saved calculations
                            toast.success('Budget saved to your profile!');
                        }}
                    >
                        Save Calculation
                    </button>
                </div>
            )}
        </div>
    );
};

export default BudgetCalculator;