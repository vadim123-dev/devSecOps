import React, { useState } from "react";
import { apiFetch, setAccessToken, setRefreshToken } from "../api";
import { useNavigate } from "react-router-dom";

export default function LoginPage() {
  const navigate = useNavigate();
  const [userName, setUserName] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  async function onSubmit(e) {
    e.preventDefault();
    setError("");
    setLoading(true);

    try {
        console.log("data " + userName + " password "+password)
      const data = await apiFetch("/users/authenticate", {
        method: "POST",
        body: { user_name: userName, password: password },
      });

      

      if (!data?.access_token) throw new Error("Missing access_token in response");

      setAccessToken(data.access_token);
      if (data.refresh_token) setRefreshToken(data.refresh_token);

      navigate("/", { replace: true });
    } catch (err) {
      setError(err.message || "Login failed");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div style={{ padding: 24 }}>
      <h2>Vet Clinic – Login</h2>

      <form onSubmit={onSubmit} style={{ display: "grid", gap: 10, maxWidth: 320 }}>
        <input
          placeholder="user_name"
          value={userName}
          onChange={(e) => setUserName(e.target.value.trim())}
          autoComplete="username"
          required
        />
        <input
          placeholder="password"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value.trim())}
          autoComplete="current-password"
          required
        />

        {error ? <div style={{ color: "crimson" }}>{error}</div> : null}

        <button disabled={loading}>{loading ? "Logging in..." : "Login"}</button>
      </form>
    </div>
  );
}
