# setup-project.ps1
Write-Host "Setting up Travel Blog Full-Stack Project..." -ForegroundColor Green

# Create directory structure
Write-Host "Creating directory structure..." -ForegroundColor Yellow
mkdir -Force client\src\components
mkdir -Force client\src\pages
mkdir -Force client\src\services
mkdir -Force client\src\styles
mkdir -Force client\public

mkdir -Force server\config
mkdir -Force server\controllers
mkdir -Force server\models
mkdir -Force server\routes
mkdir -Force server\middleware

mkdir -Force database

Write-Host "Directory structure created successfully!" -ForegroundColor Green

# Create package.json for server
Write-Host "Creating server package.json..." -ForegroundColor Yellow
@'
{
  "name": "travel-blog-server",
  "version": "1.0.0",
  "description": "Backend for Travel Blog",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "dotenv": "^16.3.1",
    "mysql2": "^3.6.0",
    "bcryptjs": "^2.4.3",
    "jsonwebtoken": "^9.0.2",
    "express-validator": "^7.0.1"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
'@ | Out-File -FilePath "server\package.json" -Encoding UTF8

# Create package.json for client
Write-Host "Creating client package.json..." -ForegroundColor Yellow
@'
{
  "name": "travel-blog-client",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.14.2",
    "axios": "^1.4.0",
    "react-icons": "^4.10.1",
    "react-hook-form": "^7.45.1",
    "@tanstack/react-query": "^4.32.6",
    "framer-motion": "^10.15.1",
    "react-hot-toast": "^2.4.1"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "proxy": "http://localhost:5000",
  "devDependencies": {
    "react-scripts": "5.0.1"
  },
  "eslintConfig": {
    "extends": [
      "react-app"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
'@ | Out-File -FilePath "client\package.json" -Encoding UTF8

# Create basic server.js
Write-Host "Creating server.js..." -ForegroundColor Yellow
@'
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
    res.json({ message: 'Travel Blog API is running!' });
});

// API routes will be added here
app.get('/api/destinations', (req, res) => {
    res.json([
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
    ]);
});

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
    console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});
'@ | Out-File -FilePath "server\server.js" -Encoding UTF8

# Create .env file for server
Write-Host "Creating server .env file..." -ForegroundColor Yellow
@'
NODE_ENV=development
PORT=5000

# Database Configuration
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=travel_blog

# JWT Secret
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
'@ | Out-File -FilePath "server\.env" -Encoding UTF8

# Create database schema
Write-Host "Creating database schema..." -ForegroundColor Yellow
@'
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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO destinations (name, country, description, image_url, type, badge, season, recommended_days, cost_range) VALUES
('Santorini', 'Greece', 'Famous for its dramatic views, stunning sunsets, and white-washed buildings with blue domes overlooking the Aegean Sea.', 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-4.0.3&auto=format&fit=crop&w=686&q=80', 'beach', 'Popular', 'Summer', 7, '$$$'),
('Kyoto', 'Japan', 'Known for its numerous classical Buddhist temples, as well as gardens, imperial palaces, and traditional wooden houses.', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80', 'city', 'Cultural', 'Spring', 10, '$$'),
('Machu Picchu', 'Peru', 'An ancient Incan city set high in the Andes Mountains, renowned for its sophisticated dry-stone walls and panoramic views.', 'https://images.unsplash.com/photo-1513326738677-b964603b136d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80', 'hiking', 'Adventure', 'Dry Season', 5, '$$');

-- Insert sample user (password: password123)
INSERT INTO users (name, email, password, travel_interest) VALUES
('John Doe', 'john@example.com', '$2b$10$YourHashedPasswordHere', 'adventure');
'@ | Out-File -FilePath "database\schema.sql" -Encoding UTF8

# Create basic React files
Write-Host "Creating React app files..." -ForegroundColor Yellow

# Create index.html
@'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="icon" href="%PUBLIC_URL%/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <meta name="description" content="Global Explorer - Travel Blog" />
    <link rel="apple-touch-icon" href="%PUBLIC_URL%/logo192.png" />
    <link rel="manifest" href="%PUBLIC_URL%/manifest.json" />
    <title>Global Explorer | Travel Blog</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
</body>
</html>
'@ | Out-File -FilePath "client\public\index.html" -Encoding UTF8

# Create App.js
@'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Toaster } from 'react-hot-toast';
import './App.css';

// Components
import Navbar from './components/Navbar';
import Footer from './components/Footer';

// Pages
import Home from './pages/Home';
import Destinations from './pages/Destinations';

function App() {
    const queryClient = new QueryClient();
    
    return (
        <QueryClientProvider client={queryClient}>
            <Router>
                <div className="App">
                    <Navbar />
                    <main>
                        <Routes>
                            <Route path="/" element={<Home />} />
                            <Route path="/destinations" element={<Destinations />} />
                        </Routes>
                    </main>
                    <Footer />
                    <Toaster position="top-right" />
                </div>
            </Router>
        </QueryClientProvider>
    );
}

export default App;
'@ | Out-File -FilePath "client\src\App.js" -Encoding UTF8

# Create index.js
@'
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
'@ | Out-File -FilePath "client\src\index.js" -Encoding UTF8

# Create index.css
@'
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
    monospace;
}
'@ | Out-File -FilePath "client\src\index.css" -Encoding UTF8

# Create App.css
@'
:root {
  --primary-color: #1a6b9c;
  --secondary-color: #ff7e5f;
  --accent-color: #4CAF50;
  --dark-color: #2c3e50;
  --light-color: #f8f9fa;
  --text-color: #444;
  --shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  --shadow-dark: 0 10px 30px rgba(0, 0, 0, 0.2);
  --transition: all 0.3s ease;
  --border-radius: 10px;
}

body {
  line-height: 1.6;
  color: var(--text-color);
  background-color: var(--light-color);
}

.container {
  width: 90%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 15px;
}

/* Navigation */
.navbar {
  background-color: white;
  box-shadow: var(--shadow);
  position: fixed;
  width: 100%;
  top: 0;
  z-index: 1000;
}

.nav-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 0;
}

.logo {
  font-size: 1.8rem;
  font-weight: 800;
  color: var(--primary-color);
  display: flex;
  align-items: center;
  gap: 10px;
}

.logo span {
  color: var(--secondary-color);
}

/* Buttons */
.btn {
  display: inline-block;
  padding: 12px 28px;
  background-color: var(--secondary-color);
  color: white;
  border-radius: 30px;
  font-weight: 600;
  border: none;
  cursor: pointer;
  transition: var(--transition);
  text-align: center;
  text-decoration: none;
}

.btn-primary {
  background-color: var(--primary-color);
}

.btn-accent {
  background-color: var(--accent-color);
}

.btn:hover {
  transform: translateY(-3px);
  box-shadow: var(--shadow);
}

/* Hero Section */
.hero {
  padding: 180px 0 100px;
  background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1469474968028-56623f02e42e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1174&q=80');
  background-size: cover;
  background-position: center;
  color: white;
  text-align: center;
  position: relative;
}

.hero h1 {
  font-size: 3.5rem;
  margin-bottom: 1.5rem;
}

.hero p {
  font-size: 1.2rem;
  max-width: 700px;
  margin: 0 auto 2rem;
  opacity: 0.9;
}

/* Destination Cards */
.destination-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.destination-card {
  background-color: white;
  border-radius: var(--border-radius);
  overflow: hidden;
  box-shadow: var(--shadow);
  transition: var(--transition);
}

.destination-card:hover {
  transform: translateY(-10px);
  box-shadow: var(--shadow-dark);
}

.destination-img {
  height: 220px;
  width: 100%;
  object-fit: cover;
}

.destination-info {
  padding: 1.5rem;
}

.destination-info h3 {
  margin-bottom: 0.5rem;
}

.destination-meta {
  display: flex;
  justify-content: space-between;
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: 1px solid #eee;
  font-size: 0.9rem;
  color: #777;
}

/* Footer */
footer {
  background-color: var(--dark-color);
  color: white;
  padding: 60px 0 20px;
  margin-top: 4rem;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin-bottom: 2rem;
}

/* Responsive */
@media (max-width: 768px) {
  .hero h1 {
    font-size: 2.5rem;
  }
  
  .destination-grid {
    grid-template-columns: 1fr;
  }
}
'@ | Out-File -FilePath "client\src\App.css" -Encoding UTF8

# Create Navbar component
@'
import React from 'react';
import { Link } from 'react-router-dom';
import { FaGlobeAmericas, FaHome, FaMapMarkedAlt, FaFeatherAlt } from 'react-icons/fa';

const Navbar = () => {
    return (
        <nav className="navbar">
            <div className="container nav-container">
                <Link to="/" className="logo">
                    <FaGlobeAmericas />
                    Global<span>Explorer</span>
                </Link>
                
                <div className="nav-links">
                    <Link to="/"><FaHome /> Home</Link>
                    <Link to="/destinations"><FaMapMarkedAlt /> Destinations</Link>
                    <Link to="/stories"><FaFeatherAlt /> Stories</Link>
                    <Link to="/login" className="btn login-btn">Login</Link>
                    <Link to="/register" className="btn signup-btn">Sign Up</Link>
                </div>
            </div>
        </nav>
    );
};

export default Navbar;
'@ | Out-File -FilePath "client\src\components\Navbar.js" -Encoding UTF8

# Create Footer component
@'
import React from 'react';
import { FaGlobeAmericas, FaFacebookF, FaTwitter, FaInstagram } from 'react-icons/fa';

const Footer = () => {
    return (
        <footer>
            <div className="container">
                <div className="footer-content">
                    <div className="footer-about">
                        <div className="footer-logo">
                            <FaGlobeAmericas />
                            Global<span>Explorer</span>
                        </div>
                        <p>We're a community of passionate travelers sharing stories, tips, and tools to make travel planning easier.</p>
                        <div className="social-icons">
                            <a href="#"><FaFacebookF /></a>
                            <a href="#"><FaTwitter /></a>
                            <a href="#"><FaInstagram /></a>
                        </div>
                    </div>
                    <div className="footer-links">
                        <h3>Quick Links</h3>
                        <ul>
                            <li><a href="/">Home</a></li>
                            <li><a href="/destinations">Destinations</a></li>
                            <li><a href="/stories">Travel Stories</a></li>
                            <li><a href="/about">About Us</a></li>
                        </ul>
                    </div>
                </div>
                <div className="copyright">
                    <p>&copy; 2023 Global Explorer Travel Blog. All rights reserved.</p>
                </div>
            </div>
        </footer>
    );
};

export default Footer;
'@ | Out-File -FilePath "client\src\components\Footer.js" -Encoding UTF8

# Create Home page
@'
import React from 'react';
import { Link } from 'react-router-dom';
import { FaSearch } from 'react-icons/fa';

const Home = () => {
    return (
        <div className="home-page">
            {/* Hero Section */}
            <section className="hero">
                <div className="container">
                    <div className="hero-content">
                        <h1>Discover The World With Confidence</h1>
                        <p>Your ultimate travel companion for exploring breathtaking destinations, planning perfect itineraries, and connecting with fellow travelers worldwide.</p>
                        <Link to="/destinations" className="btn btn-primary">Start Exploring</Link>
                        
                        <div className="hero-search">
                            <input type="text" placeholder="Search destinations, stories, or tips..." />
                            <button className="btn btn-accent"><FaSearch /> Search</button>
                        </div>
                    </div>
                </div>
            </section>
            
            {/* Stats Section */}
            <section className="stats">
                <div className="container">
                    <div className="stats-container">
                        <div className="stat-item">
                            <div className="stat-number">150+</div>
                            <div className="stat-text">Destinations Covered</div>
                        </div>
                        <div className="stat-item">
                            <div className="stat-number">850+</div>
                            <div className="stat-text">Travel Stories</div>
                        </div>
                        <div className="stat-item">
                            <div className="stat-number">25K+</div>
                            <div className="stat-text">Community Members</div>
                        </div>
                        <div className="stat-item">
                            <div className="stat-number">75+</div>
                            <div className="stat-text">Countries Explored</div>
                        </div>
                    </div>
                </div>
            </section>
            
            {/* Featured Destinations */}
            <section className="destinations">
                <div className="container">
                    <h2 className="section-title">Top Destinations</h2>
                    <div className="destination-grid">
                        <div className="destination-card">
                            <img src="https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-4.0.3&auto=format&fit=crop&w=686&q=80" alt="Santorini" />
                            <div className="destination-info">
                                <h3>Santorini</h3>
                                <p>Greece</p>
                                <div className="destination-meta">
                                    <span>Summer</span>
                                    <span>$$$</span>
                                    <span>7 days</span>
                                </div>
                                <Link to="/destinations/1" className="btn btn-primary">View Details</Link>
                            </div>
                        </div>
                        <div className="destination-card">
                            <img src="https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80" alt="Kyoto" />
                            <div className="destination-info">
                                <h3>Kyoto</h3>
                                <p>Japan</p>
                                <div className="destination-meta">
                                    <span>Spring</span>
                                    <span>$$</span>
                                    <span>10 days</span>
                                </div>
                                <Link to="/destinations/2" className="btn btn-primary">View Details</Link>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
};

export default Home;
'@ | Out-File -FilePath "client\src\pages\Home.js" -Encoding UTF8

# Create Destinations page
@'
import React, { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { FaSearch, FaFilter } from 'react-icons/fa';

const Destinations = () => {
    const [filters, setFilters] = useState({
        type: '',
        search: ''
    });

    // Fetch destinations from API
    const { data, isLoading, error } = useQuery({
        queryKey: ['destinations'],
        queryFn: async () => {
            const response = await fetch('http://localhost:5000/api/destinations');
            if (!response.ok) throw new Error('Failed to fetch destinations');
            return response.json();
        }
    });

    return (
        <div className="destinations-page">
            <div className="container">
                <h1 className="section-title">Explore Destinations</h1>
                
                {/* Search and Filters */}
                <div className="filters-section">
                    <div className="search-box">
                        <input 
                            type="text" 
                            placeholder="Search destinations..."
                            value={filters.search}
                            onChange={(e) => setFilters({...filters, search: e.target.value})}
                        />
                        <button><FaSearch /></button>
                    </div>
                    
                    <div className="filter-buttons">
                        <button onClick={() => setFilters({...filters, type: ''})}>All</button>
                        <button onClick={() => setFilters({...filters, type: 'beach'})}>Beach</button>
                        <button onClick={() => setFilters({...filters, type: 'city'})}>City</button>
                        <button onClick={() => setFilters({...filters, type: 'hiking'})}>Hiking</button>
                    </div>
                </div>
                
                {/* Loading State */}
                {isLoading && <div>Loading destinations...</div>}
                
                {/* Error State */}
                {error && <div>Error loading destinations: {error.message}</div>}
                
                {/* Destinations Grid */}
                <div className="destination-grid">
                    {data && data.map(destination => (
                        <div key={destination.id} className="destination-card">
                            <img src={destination.image_url} alt={destination.name} />
                            <div className="destination-info">
                                <h3>{destination.name}</h3>
                                <p>{destination.country}</p>
                                <p>{destination.description}</p>
                                <div className="destination-meta">
                                    <span>{destination.season}</span>
                                    <span>{destination.cost_range}</span>
                                    <span>{destination.recommended_days} days</span>
                                </div>
                                <button className="btn btn-primary">View Details</button>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default Destinations;
'@ | Out-File -FilePath "client\src\pages\Destinations.js" -Encoding UTF8

Write-Host "`nProject setup completed!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Navigate to server directory: cd server" -ForegroundColor Cyan
Write-Host "2. Install dependencies: npm install" -ForegroundColor Cyan
Write-Host "3. Start the server: npm run dev" -ForegroundColor Cyan
Write-Host "4. In a new terminal, navigate to client directory: cd ../client" -ForegroundColor Cyan
Write-Host "5. Install client dependencies: npm install" -ForegroundColor Cyan
Write-Host "6. Start React app: npm start" -ForegroundColor Cyan
Write-Host "`nOpen http://localhost:3000 in your browser" -ForegroundColor Green