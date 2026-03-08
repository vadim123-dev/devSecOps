// src/pages/Dashboard.jsx
import React from "react";
import { useAuth } from "../auth/AuthContext";
import { apiFetch } from "../api";

export default function Dashboard() {
  const { logout } = useAuth();

  async function testAuthCall() {
    // Example of an authenticated request (token is attached automatically)
    // Your backend can have something like GET /me
    const data = await apiFetch("/users/current");
    alert(typeof data === "string" ? data : JSON.stringify(data, null, 2));
  }

  return (
    <div style={{ padding: 20 }}>
      <h2>Vet Clinic Dashboard</h2>
      <p>You’re logged in. Next step: patients, appointments, etc.</p>

      <div style={{ display: "flex", gap: 10 }}>
        <button onClick={testAuthCall}>Test authenticated call</button>
        <button onClick={logout}>Logout</button>
      </div>
    </div>
  );
}
