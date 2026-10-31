const express = require('express');
const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../middleware/auth');

const router = express.Router();

// Mock in-memory user registry
const users = [
  { id: '1', email: 'emilys@abould.com', username: 'emilys', password: 'password123', name: 'Emily Smith' },
];

router.post('/register', (req, res) => {
  const { email, password, name } = req.body;
  if (!email || !password) {
    return res.status(400).json({
      success: false,
      error: { code: 'bad_request', message: 'Email and password are required.' },
    });
  }

  const existing = users.find((u) => u.email.toLowerCase() === email.toLowerCase());
  if (existing) {
    return res.status(409).json({
      success: false,
      error: { code: 'user_exists', message: 'A user with this email already exists.' },
    });
  }

  const newUser = { id: String(users.length + 1), email, password, name: name || 'New User' };
  users.push(newUser);

  const token = jwt.sign({ id: newUser.id, email: newUser.email }, JWT_SECRET, { expiresIn: '1h' });
  const refreshToken = jwt.sign({ id: newUser.id }, JWT_SECRET, { expiresIn: '7d' });

  return res.status(201).json({
    success: true,
    data: {
      user: { id: newUser.id, email: newUser.email, name: newUser.name },
      token,
      refreshToken,
    },
  });
});

router.post('/login', (req, res) => {
  const { username, email, password } = req.body;
  const identifier = (email || username || '').toLowerCase();

  const user = users.find(
    (u) => (u.email.toLowerCase() === identifier || u.username?.toLowerCase() === identifier) && u.password === password
  );

  if (!user) {
    return res.status(401).json({
      success: false,
      error: { code: 'invalid_credentials', message: 'Invalid username/email or password.' },
    });
  }

  const token = jwt.sign({ id: user.id, email: user.email }, JWT_SECRET, { expiresIn: '1h' });
  const refreshToken = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '7d' });

  return res.json({
    success: true,
    data: {
      user: { id: user.id, email: user.email, name: user.name },
      token,
      refreshToken,
    },
  });
});

router.post('/refresh-token', (req, res) => {
  const { refreshToken } = req.body;
  if (!refreshToken) {
    return res.status(400).json({
      success: false,
      error: { code: 'missing_token', message: 'Refresh token is required.' },
    });
  }

  jwt.verify(refreshToken, JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({
        success: false,
        error: { code: 'invalid_refresh_token', message: 'Refresh token expired or invalid.' },
      });
    }

    const user = users.find((u) => u.id === decoded.id);
    const newToken = jwt.sign({ id: user ? user.id : decoded.id, email: user ? user.email : '' }, JWT_SECRET, {
      expiresIn: '1h',
    });

    return res.json({
      success: true,
      data: { token: newToken },
    });
  });
});

module.exports = router;
