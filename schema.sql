-- Create database
CREATE DATABASE IF NOT EXISTS travel_blog;
USE travel_blog;

-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    travel_interest VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Destinations table
CREATE TABLE destinations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(500),
    type VARCHAR(50),
    badge VARCHAR(50),
    season VARCHAR(50),
    recommended_days INT,
    cost_range VARCHAR(10),
    best_time VARCHAR(100),
    language VARCHAR(100),
    currency VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Destination highlights
CREATE TABLE destination_highlights (
    id INT PRIMARY KEY AUTO_INCREMENT,
    destination_id INT,
    highlight VARCHAR(255),
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE
);

-- Destination tips
CREATE TABLE destination_tips (
    id INT PRIMARY KEY AUTO_INCREMENT,
    destination_id INT,
    tip VARCHAR(255),
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE
);

-- Travel stories
CREATE TABLE stories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    content TEXT NOT NULL,
    excerpt TEXT,
    image_url VARCHAR(500),
    category VARCHAR(50),
    read_time VARCHAR(20),
    likes INT DEFAULT 0,
    views INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Comments
CREATE TABLE comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    story_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (story_id) REFERENCES stories(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Newsletter subscriptions
CREATE TABLE newsletter_subscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User itineraries
CREATE TABLE itineraries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    name VARCHAR(200),
    destination VARCHAR(100),
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Itinerary activities
CREATE TABLE itinerary_activities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    itinerary_id INT,
    day_number INT,
    time_slot VARCHAR(20), -- morning, afternoon, evening
    activity TEXT,
    notes TEXT,
    FOREIGN KEY (itinerary_id) REFERENCES itineraries(id) ON DELETE CASCADE
);

-- Packing lists
CREATE TABLE packing_lists (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    destination VARCHAR(100),
    trip_type VARCHAR(50),
    season VARCHAR(50),
    duration VARCHAR(50),
    list_data JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Budget calculations
CREATE TABLE budget_calculations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    destination VARCHAR(100),
    days INT,
    travelers INT,
    accommodation_type VARCHAR(50),
    meal_budget VARCHAR(50),
    transport_type VARCHAR(50),
    total_budget DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Indexes for better performance
CREATE INDEX idx_destinations_type ON destinations(type);
CREATE INDEX idx_stories_category ON stories(category);
CREATE INDEX idx_stories_created ON stories(created_at);