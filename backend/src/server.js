const express = require('express');
const cors = require('cors');
const path = require('path');

const authRoutes = require('./routes/auth.routes');
const productRoutes = require('./routes/product.routes');
const uploadRoutes = require('./routes/upload.routes');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve uploaded static files
app.use('/uploads', express.static(path.join(__dirname, '../uploads')));

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'abould-ada-backend', timestamp: new Date().toISOString() });
});

// Mount modular API routes
app.use('/api/auth', authRoutes);
app.use('/api/products', productRoutes);
app.use('/api/upload', uploadRoutes);

// Global 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    error: {
      code: 'not_found',
      message: `Endpoint ${req.method} ${req.path} not found.`,
    },
  });
});

// Centralized error handling middleware
app.use((err, req, res, next) => {
  console.error('[Backend Error]', err);
  res.status(err.status || 500).json({
    success: false,
    error: {
      code: err.code || 'internal_server_error',
      message: err.message || 'An unexpected error occurred.',
    },
  });
});

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Abould ADA Reference API Backend running on http://localhost:${PORT}`);
  });
}

module.exports = app;
