const pool = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

class User {
    static async findByEmail(email) {
        const [rows] = await pool.execute(
            'SELECT * FROM users WHERE email = ?',
            [email]
        );
        return rows[0] || null;
    }
    
    static async findById(id) {
        const [rows] = await pool.execute(
            'SELECT id, name, email, travel_interest, created_at FROM users WHERE id = ?',
            [id]
        );
        return rows[0] || null;
    }
    
    static async create(userData) {
        const { name, email, password, travel_interest } = userData;
        
        // Hash password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        
        const [result] = await pool.execute(
            'INSERT INTO users (name, email, password, travel_interest) VALUES (?, ?, ?, ?)',
            [name, email, hashedPassword, travel_interest]
        );
        
        return result.insertId;
    }
    
    static async comparePassword(password, hashedPassword) {
        return await bcrypt.compare(password, hashedPassword);
    }
    
    static generateToken(user) {
        return jwt.sign(
            { id: user.id, email: user.email },
            process.env.JWT_SECRET || 'your_jwt_secret',
            { expiresIn: '7d' }
        );
    }
    
    static async updateProfile(userId, updateData) {
        const { name, travel_interest } = updateData;
        
        const [result] = await pool.execute(
            'UPDATE users SET name = ?, travel_interest = ? WHERE id = ?',
            [name, travel_interest, userId]
        );
        
        return result.affectedRows > 0;
    }
}

module.exports = User;