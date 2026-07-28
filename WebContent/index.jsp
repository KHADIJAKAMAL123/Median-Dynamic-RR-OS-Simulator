<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Median Dynamic Quantum Simulator-RR</title>

    <!-- Bootstrap 5 CSS -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    />

    <!-- Google Fonts: Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
      rel="stylesheet"
    />

    <style>
      html {
        scroll-behavior: smooth;
      }

      body,
      html {
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        background-color: transparent;
        color: #ffffff;
        overflow-x: hidden;
      }

      /* Fixed Video Background */
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

      /* Subtle Overlay for Text Legibility */
      .dark-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background: rgba(40, 40, 55, 0.45);
        backdrop-filter: blur(2px);
        z-index: -1;
        pointer-events: none;
      }

      /* Navbar Styling */
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

      /* Main Hero Section */
      .hero-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding-top: 70px;
        padding-bottom: 40px;
      }

      /* Swirl / Organic Shaped Main Hero Card */
      .swirl-hero-card {
        background: rgba(255, 255, 255, 0.04);
        border-radius: 40px 14px 40px 14px;
        border: 1px solid rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(25px);
        padding: 55px 50px;
        box-shadow:
          0 20px 40px rgba(0, 0, 0, 0.7),
          inset 0 0 15px rgba(255, 255, 255, 0.03);
        position: relative;
        transition: all 0.4s ease;
      }
      .swirl-hero-card:hover {
        border-color: rgba(78, 205, 196, 0.4);
        box-shadow:
          0 25px 50px rgba(0, 0, 0, 0.8),
          0 0 25px rgba(78, 205, 196, 0.15);
      }

      .btn-launch {
        background: linear-gradient(135deg, #4ecdc4 0%, #2bd2a4 100%);
        color: #08080a;
        font-weight: 600;
        border-radius: 40px;
        padding: 10px 30px;
        border: none;
        font-size: 14px;
        letter-spacing: 0.4px;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
        box-shadow: 0 8px 20px rgba(78, 205, 196, 0.3);
      }
      .btn-launch:hover {
        transform: translateY(-3px) scale(1.02);
        box-shadow: 0 12px 28px rgba(78, 205, 196, 0.5);
        color: #000000;
      }

      /* Modern Detailed About Section */
      .about-section {
        padding: 80px 0;
        min-height: 100vh;
      }

      .about-main-card {
        background: rgba(14, 15, 23, 0.75);
        border-radius: 30px 12px 30px 12px;
        border: 1px solid rgba(255, 255, 255, 0.12);
        backdrop-filter: blur(20px);
        padding: 35px 30px;
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.6);
      }

      /* Original Card & Hover Style Preserved Exactly */
      .interactive-card {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 18px 8px 18px 8px;
        padding: 22px 18px;
        height: 100%;
        position: relative;
        overflow: hidden;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
      }

      .interactive-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, #ffe66d, #4ecdc4);
        opacity: 0;
        transition: opacity 0.3s ease;
      }

      .interactive-card:hover {
        transform: translateY(-6px);
        background: rgba(255, 255, 255, 0.07);
        border-color: rgba(78, 205, 196, 0.4);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5);
      }

      .interactive-card:hover::before {
        opacity: 1;
      }

      .badge-step {
        display: inline-block;
        background: rgba(78, 205, 196, 0.15);
        color: #4ecdc4;
        font-weight: 600;
        font-size: 11px;
        padding: 4px 12px;
        border-radius: 20px;
        margin-bottom: 12px;
        border: 1px solid rgba(78, 205, 196, 0.3);
      }

      .interactive-card h4 {
        color: #ffe66d;
        font-weight: 600;
        font-size: 16px;
        margin-bottom: 10px;
      }

      .interactive-card p {
        color: #c0c0c0;
        font-size: 12.5px;
        line-height: 1.6;
      }

      /* Detailed Formula Pill in Expanded About */
      .formula-box {
        background: rgba(0, 0, 0, 0.4);
        border: 1px dashed rgba(78, 205, 196, 0.5);
        padding: 8px 10px;
        border-radius: 6px;
        margin: 10px 0;
      }

      /* Footer */
      footer {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background: rgba(50, 50, 60, 0.75);
        backdrop-filter: blur(10px);
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        padding: 15px 0;
        text-align: center;
        color: #888;
        font-size: 14px;
        z-index: 1000;
      }
    </style>
  </head>
  <body>
    <!-- Fullscreen Fixed Video Background -->
    <video autoplay muted loop playsinline class="bg-video">
      <source
        src="<%=request.getContextPath()%>/videos/bgvideo.mp4"
        type="video/mp4"
      />
      <source
        src="<%=request.getContextPath()%>/video/bgvideo.mp4"
        type="video/mp4"
      />
    </video>

    <!-- Dark Overlay -->
    <div class="dark-overlay"></div>

    <!-- Sticky Navbar -->
    <nav class="navbar navbar-expand-lg navbar-glass fixed-top">
      <div class="container">
        <a class="navbar-brand" href="#home"> OS SIMULATOR</a>
        <button
          class="navbar-toggler navbar-dark"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <div class="navbar-nav ms-auto">
            <a class="nav-link" href="#home">Home</a>
            <a class="nav-link" href="#about">About Algorithm</a>
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

    <!-- Hero Home Section -->
    <section id="home" class="hero-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-8 text-center">
            <div class="swirl-hero-card">
              <h1
                class="fs-2 fw-bold text-warning mb-2"
                style="letter-spacing: -0.5px"
              >
                Median Dynamic Quantum Simulator-RR
              </h1>
              <p
                class="text-white-50 mb-3"
                style="font-weight: 300; font-size: 13.5px"
              >
                An advanced CPU scheduling paradigm engineered to eliminate
                thread latency starvation and optimize context switching via
                median burst distribution.
              </p>
              <a
                href="<%= request.getContextPath() %>/input.jsp"
                class="btn-launch"
                >Launch Simulation Studio</a
              >
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Interactive & Expanded About Section -->
    <section id="about" class="about-section">
      <div class="container">
        <div class="about-main-card">
          <div class="text-center mb-4">
            <span class="badge-step text-uppercase"
              >Architecture & Mechanics</span
            >
            <h2 class="fs-3 fw-bold text-warning mb-2">
              How The Algorithm Works
            </h2>
            <p
              class="text-white-50 max-w-75 mx-auto"
              style="font-weight: 300; font-size: 13px"
            >
              Standard Round Robin assigns a static time quantum (TQ) blindly,
              causing excessive context switches or long process response times.
              Our proposed dynamic model continuously computes adaptive TQ based
              on median queue statistics and anti-starvation mechanisms.
            </p>
          </div>

          <div class="row g-3">
            <!-- Phase 1 -->
            <div class="col-lg-4 col-md-6">
              <div class="interactive-card">
                <span class="badge-step">Phase 01</span>
                <h4>Dynamic TQ Formula</h4>
                <p>
                  Initial TQ is calculated dynamically using median burst
                  distribution to balance short and long tasks:
                </p>
                <div class="formula-box">
                  <strong class="text-info" style="font-size: 11.5px">
                    TQ = Median(BT) + (BTmax - BTmin) / N
                  </strong>
                </div>
                <p class="mb-0">
                  This minimizes overall waiting times and prevents CPU
                  thrashing caused by improper quantum selection.
                </p>
              </div>
            </div>

            <!-- Phase 2 -->
            <div class="col-lg-4 col-md-6">
              <div class="interactive-card">
                <span class="badge-step">Phase 02</span>
                <h4>Priority Allocation</h4>
                <p>
                  Processes with remaining burst times below the ready queue
                  average receive a temporary execution priority boost.
                </p>
                <p class="mb-0">
                  This execution heuristic reduces remaining process count
                  rapidly, resulting in shorter average turnaround times.
                </p>
              </div>
            </div>

            <!-- Phase 3 -->
            <div class="col-lg-4 col-md-6">
              <div class="interactive-card">
                <span class="badge-step">Phase 03</span>
                <h4>Anti-Starvation Aging</h4>
                <p>
                  A wait counter continually monitors long-running processes in
                  the ready queue.
                </p>
                <p class="mb-0">
                  If any process waits for 2 or more consecutive cycles, its
                  execution priority is elevated automatically to guarantee
                  execution and eliminate starvation.
                </p>
              </div>
            </div>
          </div>

          <div class="text-center mt-4">
            <a
              href="<%= request.getContextPath() %>/input.jsp"
              class="btn-launch"
              >Run Custom Simulation</a
            >
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer>
      <div class="container">
        <p class="m-0">
          &copy; 2026 Median Dynamic Round Robin OS Simulator | All Rights
          Reserved
        </p>
      </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
