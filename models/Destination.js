const pool = require('../config/db');

class Destination {
    static async findAll(filters = {}) {
        let query = 'SELECT * FROM destinations WHERE 1=1';
        const params = [];
        
        if (filters.type) {
            query += ' AND type = ?';
            params.push(filters.type);
        }
        
        if (filters.search) {
            query += ' AND (name LIKE ? OR country LIKE ? OR description LIKE ?)';
            const searchTerm = `%${filters.search}%`;
            params.push(searchTerm, searchTerm, searchTerm);
        }
        
        query += ' ORDER BY created_at DESC';
        
        const [rows] = await pool.execute(query, params);
        return rows;
    }
    
    static async findById(id) {
        const [rows] = await pool.execute(
            'SELECT * FROM destinations WHERE id = ?',
            [id]
        );
        
        if (rows.length === 0) return null;
        
        // Get highlights and tips
        const [highlights] = await pool.execute(
            'SELECT highlight FROM destination_highlights WHERE destination_id = ?',
            [id]
        );
        
        const [tips] = await pool.execute(
            'SELECT tip FROM destination_tips WHERE destination_id = ?',
            [id]
        );
        
        return {
            ...rows[0],
            highlights: highlights.map(h => h.highlight),
            tips: tips.map(t => t.tip)
        };
    }
    
    static async create(destinationData) {
        const {
            name, country, description, image_url, type,
            badge, season, recommended_days, cost_range,
            best_time, language, currency, highlights, tips
        } = destinationData;
        
        const connection = await pool.getConnection();
        
        try {
            await connection.beginTransaction();
            
            // Insert destination
            const [result] = await connection.execute(
                `INSERT INTO destinations 
                (name, country, description, image_url, type, badge, season, 
                 recommended_days, cost_range, best_time, language, currency) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [name, country, description, image_url, type, badge, season,
                 recommended_days, cost_range, best_time, language, currency]
            );
            
            const destinationId = result.insertId;
            
            // Insert highlights
            if (highlights && highlights.length > 0) {
                const highlightValues = highlights.map(highlight => 
                    [destinationId, highlight]
                );
                await connection.query(
                    'INSERT INTO destination_highlights (destination_id, highlight) VALUES ?',
                    [highlightValues]
                );
            }
            
            // Insert tips
            if (tips && tips.length > 0) {
                const tipValues = tips.map(tip => 
                    [destinationId, tip]
                );
                await connection.query(
                    'INSERT INTO destination_tips (destination_id, tip) VALUES ?',
                    [tipValues]
                );
            }
            
            await connection.commit();
            return destinationId;
            
        } catch (error) {
            await connection.rollback();
            throw error;
        } finally {
            connection.release();
        }
    }
    
    static async update(id, destinationData) {
        // Similar to create but with UPDATE
        // Implementation omitted for brevity
    }
    
    static async delete(id) {
        const [result] = await pool.execute(
            'DELETE FROM destinations WHERE id = ?',
            [id]
        );
        return result.affectedRows > 0;
    }
}

module.exports = Destination;