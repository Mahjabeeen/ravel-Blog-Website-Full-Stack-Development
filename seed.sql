USE travel_blog;

-- Insert sample destinations
INSERT INTO destinations (name, country, description, image_url, type, badge, season, recommended_days, cost_range, best_time, language, currency) VALUES
('Santorini', 'Greece', 'Famous for its dramatic views, stunning sunsets, and white-washed buildings with blue domes overlooking the Aegean Sea.', 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-4.0.3&auto=format&fit=crop&w=686&q=80', 'beach', 'Popular', 'Summer', 7, '$$$', 'April to October', 'Greek', 'Euro (€)'),
('Kyoto', 'Japan', 'Known for its numerous classical Buddhist temples, as well as gardens, imperial palaces, and traditional wooden houses.', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80', 'city', 'Cultural', 'Spring', 10, '$$', 'March to May, September to November', 'Japanese', 'Yen (¥)'),
('Machu Picchu', 'Peru', 'An ancient Incan city set high in the Andes Mountains, renowned for its sophisticated dry-stone walls and panoramic views.', 'https://images.unsplash.com/photo-1513326738677-b964603b136d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80', 'hiking', 'Adventure', 'Dry Season', 5, '$$', 'May to September', 'Spanish, Quechua', 'Sol (S/)');

-- Insert destination highlights
INSERT INTO destination_highlights (destination_id, highlight) VALUES
(1, 'Oia Sunset'),
(1, 'Red Beach'),
(1, 'Ancient Thera'),
(1, 'Wine Tasting'),
(2, 'Fushimi Inari Shrine'),
(2, 'Kinkaku-ji Temple'),
(2, 'Arashiyama Bamboo Grove'),
(2, 'Gion District');

-- Insert destination tips
INSERT INTO destination_tips (destination_id, tip) VALUES
(1, 'Book accommodations early'),
(1, 'Rent an ATV for transportation'),
(1, 'Try local seafood'),
(2, 'Get a Japan Rail Pass'),
(2, 'Visit temples early to avoid crowds'),
(2, 'Try kaiseki cuisine');

-- Insert sample user
INSERT INTO users (name, email, password, travel_interest) VALUES
('John Doe', 'john@example.com', '$2b$10$YourHashedPasswordHere', 'adventure');