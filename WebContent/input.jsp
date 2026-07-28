<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Simulator Configuration Setup</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <style>
      body,
      html {
        min-height: 100%;
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        background: transparent;
        color: #f0f0f0;
        overflow-x: hidden;
      }

      .bg-video {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        object-fit: cover;
        z-index: -2;
        pointer-events: none;
      }

      .dark-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background: rgba(40, 40, 55, 0.45);
        backdrop-filter: blur(3px);
        z-index: -1;
        pointer-events: none;
      }

      .navbar-glass {
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(14px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        padding: 10px 0;
      }
      .navbar-brand {
        color: #ffe66d !important;
        font-weight: 700;
        font-size: 1.1rem;
      }
      .nav-link {
        color: #ffffff !important;
        margin: 0 8px;
        font-size: 0.9rem;
      }
      .nav-link:hover,
      .nav-link.active {
        color: #4ecdc4 !important;
      }

      .main-container {
        padding-top: 95px;
        padding-bottom: 60px;
      }

      .glass-card {
        background: rgba(255, 255, 255, 0.04);
        border-radius: 16px;
        border: 1px solid rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(25px);
        padding: 30px 35px;
        box-shadow: 0 12px 30px rgba(0, 0, 0, 0.5);
      }

      h2 {
        color: #ffe66d;
        font-weight: 700;
        text-align: center;
        margin-bottom: 20px;
        font-size: 1.5rem;
      }
      .form-label {
        font-weight: 600;
        color: #4ecdc4;
        margin-bottom: 6px;
        font-size: 0.9rem;
      }

      .form-control {
        background: rgba(255, 255, 255, 0.06) !important;
        color: #ffffff !important;
        border: 1px solid rgba(255, 255, 255, 0.18);
        border-radius: 8px;
        padding: 8px 12px;
        font-size: 0.9rem;
      }

      .inner-process-row {
        background: rgba(0, 0, 0, 0.35);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 10px;
        padding: 14px;
        margin-bottom: 14px;
      }

      .process-title {
        color: #ffe66d;
        font-weight: 600;
        font-size: 0.92rem;
        margin-bottom: 8px;
      }

      .btn-submit {
        background: linear-gradient(135deg, #4ecdc4 0%, #2bd2a4 100%);
        color: #0c0c0e;
        font-weight: 700;
        border-radius: 24px;
        padding: 10px 20px;
        border: none;
        width: 100%;
        margin-top: 10px;
        font-size: 0.95rem;
      }

      footer {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background: rgba(50, 50, 60, 0.75);
        backdrop-filter: blur(10px);
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        padding: 12px 0;
        text-align: center;
        color: #aaa;
        font-size: 0.85rem;
        z-index: 1000;
      }
    </style>
  </head>
  <body>
    <video id="bgVideo" autoplay muted loop playsinline class="bg-video">
      <source
        src="<%= request.getContextPath() %>/videos/bgvideo.mp4"
        type="video/mp4"
      />
      <source
        src="<%= request.getContextPath() %>/video/bgvideo.mp4"
        type="video/mp4"
      />
    </video>

    <div class="dark-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-glass fixed-top">
      <div class="container">
        <a
          class="navbar-brand"
          href="<%= request.getContextPath() %>/index.jsp"
        >
          OS SIMULATOR</a
        >
        <div class="ms-auto">
          <div class="navbar-nav">
            <a class="nav-link" href="<%= request.getContextPath() %>/index.jsp"
              >Home</a
            >
            <a
              class="nav-link"
              href="<%= request.getContextPath() %>/compare.jsp"
              >Simulation Results</a
            >
            <a
              class="nav-link"
              href="<%= request.getContextPath() %>/contact.jsp"
              >Contact</a
            >
          </div>
        </div>
      </div>
    </nav>

    <div class="container main-container">
      <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
          <div class="glass-card">
            <h2>Enter Process Details</h2>

            <form
              action="<%= request.getContextPath() %>/DynamicRR"
              method="POST"
            >
              <div class="mb-4">
                <label class="form-label">Number of Processes</label>
                <input
                  type="number"
                  name="num"
                  id="numProcesses"
                  class="form-control"
                  min="1"
                  max="10"
                  required
                  placeholder="Enter total processes (e.g., 3)"
                />
              </div>

              <div id="dynamicContainer"></div>

              <button type="submit" class="btn btn-submit shadow">
                Run Dynamic RR Algorithm
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <footer>
      <div class="container">
        <p class="m-0">
          &copy; 2026 Median Dynamic Round Robin OS Simulator | All Rights
          Reserved
        </p>
      </div>
    </footer>

    <script>
      document
        .getElementById("numProcesses")
        .addEventListener("input", function () {
          const val = parseInt(this.value);
          const container = document.getElementById("dynamicContainer");
          container.innerHTML = "";
          if (isNaN(val) || val <= 0) return;

          for (let i = 1; i <= val; i++) {
            const div = document.createElement("div");
            div.className = "inner-process-row";
            div.innerHTML = `
            <div class="process-title">Process \${i}</div>
            <div class="row g-2">
              <div class="col-4">
                <label class="form-label text-white-50 small mb-1">Process ID</label>
                <input type="text" name="pid\${i}" class="form-control" value="P\${i}" required>
              </div>
              <div class="col-4">
                <label class="form-label text-white-50 small mb-1">Arrival Time</label>
                <input type="number" name="arrival\${i}" class="form-control" placeholder="0" min="0" required>
              </div>
              <div class="col-4">
                <label class="form-label text-white-50 small mb-1">Burst Time</label>
                <input type="number" name="burst\${i}" class="form-control" placeholder="1" min="1" required>
              </div>
            </div>
          `;
            container.appendChild(div);
          }
        });
    </script>
  </body>
</html>
