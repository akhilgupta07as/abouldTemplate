const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'abould-ada-jwt-secret-key-2026';

function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({
      success: false,
      error: {
        code: 'unauthorized',
        message: 'Authentication token required.',
      },
    });
  }

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) {
      return res.status(403).json({
        success: false,
        error: {
          code: 'token_expired_or_invalid',
          message: 'The token provided is invalid or has expired.',
        },
      });
    }
    req.user = user;
    next();
  });
}

module.exports = {
  authenticateToken,
  JWT_SECRET,
};
