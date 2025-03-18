const express = require('express');
const cors = require('cors');
const { testConnection } = require('./config/db');
const authRoutes = require('./routes/auth');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors({
  origin: '*', // Allow all origins
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json());

// Test database connection
testConnection()
  .then(() => {
    console.log('Database connection test completed');
  })
  .catch(err => {
    console.error('Database connection test failed:', err);
  });

// Routes
app.use('/api/auth', authRoutes);

// Basic route
app.get('/', (req, res) => {
  res.json({ 
    message: 'Welcome to AttendanceX API',
    serverIP: process.env.SERVER_IP || 'Not configured'
  });
});

// Start server
const PORT = process.env.PORT || 5000;
const SERVER_IP = process.env.SERVER_IP;

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on http://${SERVER_IP}:${PORT}`);
}); 