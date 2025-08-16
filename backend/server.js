const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const compression = require('compression');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

const app = express();
const PORT = process.env.API_PORT || 3000;

// Middleware de segurança
app.use(helmet());
app.use(compression());

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100
});
app.use(limiter);

// CORS
app.use(cors({
  origin: [
    'https://twubus.tech',
    'https://www.twubus.tech',
    'http://localhost:3001'
  ],
  credentials: true
}));

// Middleware básico
app.use(morgan('combined'));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Health check
app.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    service: 'TWU Bus Dashboard API',
    version: '1.0.0'
  });
});

// Rotas da API
app.get('/api/routes', (req, res) => {
  res.json({ 
    message: 'Bus routes endpoint',
    routes: [
      { id: 'R001', name: 'Campus Circular', color: '#FF6B35' },
      { id: 'R002', name: 'Downtown Express', color: '#004AAD' },
      { id: 'R003', name: 'Residential Loop', color: '#00A651' }
    ]
  });
});

app.get('/api/stops', (req, res) => {
  res.json({ 
    message: 'Bus stops endpoint',
    stops: [
      { id: 'S001', name: 'TWU Main Campus', lat: 33.2148, lon: -97.1331 },
      { id: 'S002', name: 'Student Center', lat: 33.2156, lon: -97.1340 },
      { id: 'S003', name: 'Library', lat: 33.2140, lon: -97.1325 }
    ]
  });
});

app.get('/api/vehicles', (req, res) => {
  res.json({ 
    message: 'Active vehicles',
    vehicles: [
      { id: 'V001', route: 'R001', lat: 33.2150, lon: -97.1335, speed: 25 },
      { id: 'V002', route: 'R002', lat: 33.2170, lon: -97.1350, speed: 30 }
    ]
  });
});

// Rota catch-all
app.get('*', (req, res) => {
  res.json({ 
    message: 'TWU Bus Dashboard API',
    version: '1.0.0',
    endpoints: [
      'GET /health',
      'GET /api/routes',
      'GET /api/stops', 
      'GET /api/vehicles'
    ]
  });
});

app.listen(PORT, () => {
  console.log(`🚀 TWU Bus API running on port ${PORT}`);
});
