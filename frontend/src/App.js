import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [routes, setRoutes] = useState([]);
  const [stops, setStops] = useState([]);
  const [vehicles, setVehicles] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const [routesRes, stopsRes, vehiclesRes] = await Promise.all([
        fetch('/api/routes'),
        fetch('/api/stops'),
        fetch('/api/vehicles')
      ]);

      const routesData = await routesRes.json();
      const stopsData = await stopsRes.json();
      const vehiclesData = await vehiclesRes.json();

      setRoutes(routesData.routes || []);
      setStops(stopsData.stops || []);
      setVehicles(vehiclesData.vehicles || []);
    } catch (error) {
      console.error('Error fetching data:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="App">
        <div className="loading">Loading TWU Bus Dashboard...</div>
      </div>
    );
  }

  return (
    <div className="App">
      <header className="App-header">
        <h1>🚌 TWU Bus Dashboard</h1>
        <p>Real-time Bus Tracking System</p>
      </header>

      <main className="dashboard">
        <section className="routes-section">
          <h2>🛣️ Bus Routes</h2>
          <div className="cards-grid">
            {routes.map(route => (
              <div key={route.id} className="card" style={{borderLeft: `4px solid ${route.color}`}}>
                <h3>{route.name}</h3>
                <p>Route ID: {route.id}</p>
              </div>
            ))}
          </div>
        </section>

        <section className="stops-section">
          <h2>🚏 Bus Stops</h2>
          <div className="cards-grid">
            {stops.map(stop => (
              <div key={stop.id} className="card">
                <h3>{stop.name}</h3>
                <p>📍 {stop.lat}, {stop.lon}</p>
              </div>
            ))}
          </div>
        </section>

        <section className="vehicles-section">
          <h2>🚐 Active Vehicles</h2>
          <div className="cards-grid">
            {vehicles.map(vehicle => (
              <div key={vehicle.id} className="card vehicle-card">
                <h3>Vehicle {vehicle.id}</h3>
                <p>Route: {vehicle.route}</p>
                <p>Speed: {vehicle.speed} mph</p>
                <p>📍 {vehicle.lat}, {vehicle.lon}</p>
              </div>
            ))}
          </div>
        </section>
      </main>

      <footer className="App-footer">
        <p>© 2024 TWU Bus Dashboard - Real-time Transit Information</p>
      </footer>
    </div>
  );
}

export default App;
