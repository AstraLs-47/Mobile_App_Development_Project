const pool = require('../config/db');

class UserProfile {
  /**
   * Find profile by user ID with user info
   */
  static async findByUserId(userId) {
    const result = await pool.query(
      `SELECT 
        up.*,
        u.email,
        u.first_name,
        u.last_name,
        u.role
      FROM user_profiles up
      JOIN users u ON up.user_id = u.id
      WHERE up.user_id = $1`,
      [userId]
    );
    return result.rows[0] || null;
  }

  /**
   * Create or update user profile (upsert)
   */
  static async upsert({ userId, age, gender, goal, activityLevel, dateOfBirth, height, currentWeight, goalWeight }) {
    const result = await pool.query(
      `INSERT INTO user_profiles (user_id, age, gender, goal, activity_level, date_of_birth, height, current_weight, goal_weight)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
       ON CONFLICT (user_id) DO UPDATE SET
         age = EXCLUDED.age,
         gender = EXCLUDED.gender,
         goal = EXCLUDED.goal,
         activity_level = EXCLUDED.activity_level,
         date_of_birth = EXCLUDED.date_of_birth,
         height = EXCLUDED.height,
         current_weight = EXCLUDED.current_weight,
         goal_weight = EXCLUDED.goal_weight,
         updated_at = CURRENT_TIMESTAMP
       RETURNING *`,
      [userId, age, gender, goal, activityLevel, dateOfBirth, height, currentWeight, goalWeight]
    );
    return result.rows[0];
  }

  /**
   * Update specific profile fields
   */
  static async update(userId, updates) {
    const fields = [];
    const values = [];
    let paramCount = 1;

    // Map camelCase to snake_case
    const fieldMap = {
      age: 'age',
      gender: 'gender',
      goal: 'goal',
      activityLevel: 'activity_level',
      dateOfBirth: 'date_of_birth',
      height: 'height',
      currentWeight: 'current_weight',
      goalWeight: 'goal_weight'
    };

    for (const [key, dbField] of Object.entries(fieldMap)) {
      if (updates[key] !== undefined) {
        fields.push(`${dbField} = $${paramCount}`);
        values.push(updates[key]);
        paramCount++;
      }
    }

    if (fields.length === 0) return null;

    fields.push(`updated_at = CURRENT_TIMESTAMP`);
    values.push(userId);

    const result = await pool.query(
      `UPDATE user_profiles 
       SET ${fields.join(', ')}
       WHERE user_id = $${paramCount}
       RETURNING *`,
      values
    );
    return result.rows[0];
  }

  /**
   * Complete onboarding with transaction
   */
  static async onboard(userId, profileData, userData) {
    const client = await pool.connect();
    
    try {
      await client.query('BEGIN');

      // Update user names if provided
      if (userData.first_name || userData.last_name) {
        const updates = [];
        const values = [];
        let count = 1;

        if (userData.first_name) {
          updates.push(`first_name = $${count}`);
          values.push(userData.first_name);
          count++;
        }
        if (userData.last_name) {
          updates.push(`last_name = $${count}`);
          values.push(userData.last_name);
          count++;
        }

        updates.push(`updated_at = CURRENT_TIMESTAMP`);
        values.push(userId);

        await client.query(
          `UPDATE users SET ${updates.join(', ')} WHERE id = $${count}`,
          values
        );
      }

      // Upsert profile
      const { age, gender, goal, activityLevel, dateOfBirth, height, currentWeight, goalWeight } = profileData;
      
      const result = await client.query(
        `INSERT INTO user_profiles (user_id, age, gender, goal, activity_level, date_of_birth, height, current_weight, goal_weight)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
         ON CONFLICT (user_id) DO UPDATE SET
           age = EXCLUDED.age,
           gender = EXCLUDED.gender,
           goal = EXCLUDED.goal,
           activity_level = EXCLUDED.activity_level,
           date_of_birth = EXCLUDED.date_of_birth,
           height = EXCLUDED.height,
           current_weight = EXCLUDED.current_weight,
           goal_weight = EXCLUDED.goal_weight,
           updated_at = CURRENT_TIMESTAMP
         RETURNING *`,
        [userId, age, gender, goal, activityLevel, dateOfBirth, height, currentWeight, goalWeight]
      );

      await client.query('COMMIT');
      return result.rows[0];
    } catch (error) {
      await client.query('ROLLBACK');
      throw error;
    } finally {
      client.release();
    }
  }
}

module.exports = UserProfile;