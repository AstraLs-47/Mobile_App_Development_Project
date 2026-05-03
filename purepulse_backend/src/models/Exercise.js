const pool = require('../config/db');

class Exercise {
  static async findAll(categoryId, difficulty, limit = 50, offset = 0) {
    let query = `
      SELECT e.*, c.name as category_name 
      FROM exercises e
      LEFT JOIN categories c ON e.category_id = c.id
      WHERE 1=1
    `;
    const values = [];
    let paramCount = 1;

    if (categoryId) {
      query += ` AND e.category_id = $${paramCount++}`;
      values.push(categoryId);
    }
    if (difficulty) {
      query += ` AND e.difficulty = $${paramCount++}`;
      values.push(difficulty);
    }

    query += ` ORDER BY e.created_at DESC LIMIT $${paramCount++} OFFSET $${paramCount++}`;
    values.push(limit, offset);

    const result = await pool.query(query, values);
    return result.rows;
  }

  static async findById(id) {
    const result = await pool.query(
      `SELECT e.*, c.name as category_name 
       FROM exercises e
       LEFT JOIN categories c ON e.category_id = c.id
       WHERE e.id = $1`,
      [id]
    );
    return result.rows[0];
  }

  static async create(data) {
    const result = await pool.query(
      `INSERT INTO exercises (name, description, category_id, difficulty, muscle_groups, instructions, video_url, image_url, calories_per_minute)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
       RETURNING *`,
      [
        data.name,
        data.description,
        data.categoryId,
        data.difficulty,
        data.muscleGroups,
        data.instructions,
        data.videoUrl,
        data.imageUrl,
        data.caloriesPerMinute
      ]
    );
    return result.rows[0];
  }

  static async update(id, data) {
    const updates = [];
    const values = [];
    let paramCount = 1;

    const fields = {
      name: 'name',
      description: 'description',
      categoryId: 'category_id',
      difficulty: 'difficulty',
      muscleGroups: 'muscle_groups',
      instructions: 'instructions',
      videoUrl: 'video_url',
      imageUrl: 'image_url',
      caloriesPerMinute: 'calories_per_minute'
    };

    for (const [key, dbField] of Object.entries(fields)) {
      if (data[key] !== undefined) {
        updates.push(`${dbField} = $${paramCount++}`);
        values.push(data[key]);
      }
    }

    if (updates.length === 0) {
      return Exercise.findById(id);
    }

    updates.push('updated_at = CURRENT_TIMESTAMP');
    values.push(id);

    const result = await pool.query(
      `UPDATE exercises SET ${updates.join(', ')} WHERE id = $${paramCount} RETURNING *`,
      values
    );
    return result.rows[0];
  }

  static async delete(id) {
    const result = await pool.query('DELETE FROM exercises WHERE id = $1 RETURNING id', [id]);
    return result.rows[0];
  }

  static async count(categoryId, difficulty) {
    let query = 'SELECT COUNT(*) as total FROM exercises WHERE 1=1';
    const values = [];
    let paramCount = 1;

    if (categoryId) {
      query += ` AND category_id = $${paramCount++}`;
      values.push(categoryId);
    }
    if (difficulty) {
      query += ` AND difficulty = $${paramCount++}`;
      values.push(difficulty);
    }

    const result = await pool.query(query, values);
    return parseInt(result.rows[0].total, 10);
  }
}

module.exports = Exercise;
