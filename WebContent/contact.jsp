<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Contact System Maintainers</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    />
    <style>
      body,
      html {
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        background-color: transparent;
        color: #ffffff;
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
        backdrop-filter: blur(2px);
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
        padding-top: 90px;
        padding-bottom: 50px;
      }

      .glass-card {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(20px);
        padding: 28px 32px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.45);
      }

      h2 {
        color: #ffe66d;
        font-weight: 700;
        text-align: center;
        margin-bottom: 6px;
        font-size: 1.4rem;
      }

      .form-label {
        font-weight: 600;
        color: #4ecdc4;
        margin-bottom: 4px;
        font-size: 0.85rem;
      }

      /* Fixed Input & Textarea Visibility Styling */
      .form-control {
        background: rgba(0, 0, 0, 0.35) !important;
        color: #ffffff !important;
        border: 1px solid rgba(255, 255, 255, 0.25);
        border-radius: 6px;
        padding: 8px 12px;
        font-size: 0.85rem;
      }

      /* Brightened Placeholder Text Visibility */
      .form-control::placeholder {
        color: rgba(255, 255, 255, 0.65) !important;
        opacity: 1;
      }

      /* Prevent Focus state from turning white/unreadable */
      .form-control:focus {
        background: rgba(0, 0, 0, 0.55) !important;
        color: #ffffff !important;
        border-color: #4ecdc4 !important;
        box-shadow: 0 0 8px rgba(78, 205, 196, 0.4) !important;
      }

      .btn-submit {
        background: linear-gradient(135deg, #4ecdc4 0%, #2bd2a4 100%);
        color: #0c0c0e;
        font-weight: 700;
        border-radius: 20px;
        padding: 8px 18px;
        border: none;
        width: 100%;
        font-size: 0.88rem;
        transition: 0.3s;
        margin-top: 8px;
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
              >About</a
            >
            <a
              class="nav-link active"
              href="<%= request.getContextPath() %>/contact.jsp"
              >Contact</a
            >
          </div>
        </div>
      </div>
    </nav>

    <div class="container main-container">
      <div class="row justify-content-center">
        <div class="col-lg-5 col-md-7">
          <div class="glass-card shadow-lg">
            <h2>Get in Touch</h2>
            <p
              class="text-center text-white-50 mb-3"
              style="font-size: 0.82rem"
            >
              Have questions regarding algorithm behavior or performance output?
              Send us a message.
            </p>

            <div
              id="alertBox"
              class="alert alert-success d-none text-center py-1 mb-3"
              style="font-size: 0.82rem"
              role="alert"
            >
              Message submitted successfully!
            </div>

            <form
              id="contactForm"
              onsubmit="
                event.preventDefault();
                showSuccess();
              "
            >
              <div class="mb-2">
                <label class="form-label">Full Name</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Enter your full name"
                  required
                />
              </div>

              <div class="mb-2">
                <label class="form-label">Email Address</label>
                <input
                  type="email"
                  class="form-control"
                  placeholder="name@domain.com"
                  required
                />
              </div>

              <div class="mb-3">
                <label class="form-label">Query Description</label>
                <textarea
                  class="form-control"
                  rows="3"
                  placeholder="Describe your inquiry..."
                  required
                ></textarea>
              </div>

              <button type="submit" class="btn btn-submit shadow">
                Dispatch Inquiry Message
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
      function showSuccess() {
        document.getElementById("alertBox").classList.remove("d-none");
        document.getElementById("contactForm").reset();
      }
    </script>
  </body>
</html>
