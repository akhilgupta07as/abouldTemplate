const express = require('express');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

// Mock in-memory products dataset
const products = Array.from({ length: 45 }, (_, i) => ({
  id: i + 1,
  title: `Product ${i + 1} - Enterprise Solution`,
  description: `High performance scalable module designed for enterprise client projects (${i + 1}).`,
  price: (29.99 + (i * 5)).toFixed(2),
  category: i % 2 === 0 ? 'mobile-framework' : 'cloud-backend',
  rating: (4.0 + (i % 10) * 0.1).toFixed(1),
}));

// GET /api/products (supports pagination: limit, skip, and search query q)
router.get('/', (req, res) => {
  const limit = Math.max(1, parseInt(req.query.limit, 10) || 10);
  const skip = Math.max(0, parseInt(req.query.skip, 10) || 0);
  const query = (req.query.q || '').toLowerCase();

  let filtered = products;
  if (query) {
    filtered = filtered.filter(
      (p) => p.title.toLowerCase().includes(query) || p.description.toLowerCase().includes(query)
    );
  }

  const paginated = filtered.slice(skip, skip + limit);

  return res.json({
    success: true,
    data: {
      products: paginated,
      total: filtered.length,
      skip,
      limit,
    },
  });
});

// GET /api/products/:id
router.get('/:id', (req, res) => {
  const product = products.find((p) => p.id === parseInt(req.params.id, 10));
  if (!product) {
    return res.status(404).json({
      success: false,
      error: { code: 'not_found', message: 'Product not found.' },
    });
  }

  return res.json({
    success: true,
    data: product,
  });
});

// Protected POST /api/products
router.post('/', authenticateToken, (req, res) => {
  const { title, description, price, category } = req.body;
  if (!title || !price) {
    return res.status(400).json({
      success: false,
      error: { code: 'validation_error', message: 'Title and price are required.' },
    });
  }

  const newProduct = {
    id: products.length + 1,
    title,
    description: description || '',
    price: Number(price).toFixed(2),
    category: category || 'general',
    rating: '5.0',
  };

  products.push(newProduct);
  return res.status(201).json({ success: true, data: newProduct });
});

module.exports = router;
