const pool = require('../config/db');

class Product {
  static async findAll(limit = 50, offset = 0) {
    const result = await pool.query(
      `SELECT * FROM products WHERE is_active = true ORDER BY created_at DESC LIMIT $1 OFFSET $2`,
      [limit, offset]
    );
    return result.rows;
  }

  static async findById(id) {
    const result = await pool.query('SELECT * FROM products WHERE id = $1', [id]);
    return result.rows[0];
  }

  static async count() {
    const result = await pool.query('SELECT COUNT(*) as total FROM products WHERE is_active = true');
    return parseInt(result.rows[0].total, 10);
  }

  static async create(data) {
    const { name, description, category, price, stockQuantity, imageUrl } = data;
    const result = await pool.query(
      `INSERT INTO products (name, description, category, price, stock_quantity, image_url)
       VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
      [name, description, category, price, stockQuantity || 0, imageUrl]
    );
    return result.rows[0];
  }

  static async update(id, data) {
    const { name, description, category, price, stockQuantity, imageUrl, isActive } = data;
    const result = await pool.query(
      `UPDATE products SET name = $1, description = $2, category = $3, price = $4,
       stock_quantity = $5, image_url = $6, is_active = $7, updated_at = CURRENT_TIMESTAMP
       WHERE id = $8 RETURNING *`,
      [name, description, category, price, stockQuantity, imageUrl, isActive, id]
    );
    return result.rows[0];
  }

  static async delete(id) {
    await pool.query('UPDATE products SET is_active = false WHERE id = $1', [id]);
  }
}

module.exports = Product;
