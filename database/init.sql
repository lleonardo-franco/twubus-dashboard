-- TWU Bus Dashboard Database Schema

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de rotas de ônibus
CREATE TABLE IF NOT EXISTS bus_routes (
    id SERIAL PRIMARY KEY,
    route_id VARCHAR(50) UNIQUE NOT NULL,
    route_name VARCHAR(100) NOT NULL,
    route_color VARCHAR(7) DEFAULT '#0066CC',
    route_type INTEGER DEFAULT 3,
    agency_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de paradas
CREATE TABLE IF NOT EXISTS bus_stops (
    id SERIAL PRIMARY KEY,
    stop_id VARCHAR(50) UNIQUE NOT NULL,
    stop_name VARCHAR(100) NOT NULL,
    stop_lat DECIMAL(10, 8) NOT NULL,
    stop_lon DECIMAL(11, 8) NOT NULL,
    zone_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de horários
CREATE TABLE IF NOT EXISTS schedules (
    id SERIAL PRIMARY KEY,
    route_id VARCHAR(50) REFERENCES bus_routes(route_id),
    stop_id VARCHAR(50) REFERENCES bus_stops(stop_id),
    arrival_time TIME NOT NULL,
    departure_time TIME NOT NULL,
    stop_sequence INTEGER NOT NULL,
    pickup_type INTEGER DEFAULT 0,
    drop_off_type INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de veículos (ônibus)
CREATE TABLE IF NOT EXISTS vehicles (
    id SERIAL PRIMARY KEY,
    vehicle_id VARCHAR(50) UNIQUE NOT NULL,
    route_id VARCHAR(50) REFERENCES bus_routes(route_id),
    current_lat DECIMAL(10, 8),
    current_lon DECIMAL(11, 8),
    speed DECIMAL(5, 2),
    heading INTEGER,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'active'
);

-- Tabela de alertas/notificações
CREATE TABLE IF NOT EXISTS alerts (
    id SERIAL PRIMARY KEY,
    alert_type VARCHAR(50) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    route_id VARCHAR(50),
    stop_id VARCHAR(50),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_bus_routes_route_id ON bus_routes(route_id);
CREATE INDEX IF NOT EXISTS idx_bus_stops_stop_id ON bus_stops(stop_id);
CREATE INDEX IF NOT EXISTS idx_schedules_route_stop ON schedules(route_id, stop_id);
CREATE INDEX IF NOT EXISTS idx_vehicles_route_id ON vehicles(route_id);
CREATE INDEX IF NOT EXISTS idx_alerts_active ON alerts(is_active, start_time, end_time);

-- Inserir dados de exemplo
INSERT INTO bus_routes (route_id, route_name, route_color) VALUES
('R001', 'Campus Circular', '#FF6B35'),
('R002', 'Downtown Express', '#004AAD'),
('R003', 'Residential Loop', '#00A651')
ON CONFLICT (route_id) DO NOTHING;

INSERT INTO bus_stops (stop_id, stop_name, stop_lat, stop_lon) VALUES
('S001', 'TWU Main Campus', 33.2148, -97.1331),
('S002', 'Student Center', 33.2156, -97.1340),
('S003', 'Library', 33.2140, -97.1325),
('S004', 'Downtown Station', 33.2180, -97.1390),
('S005', 'Residential Area', 33.2120, -97.1310)
ON CONFLICT (stop_id) DO NOTHING;
