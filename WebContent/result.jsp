<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.scheduler.Process" %>
<%@ page import="com.scheduler.DynamicRR.GanttSlot" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Median Dynamic Quantum Simulator - Results</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { 
            background: #121212; 
            color: #fff; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            padding-top: 70px; 
            padding-bottom: 40px; 
        }
        .bg-video { 
            position: fixed; right: 0; bottom: 0; min-width: 100%; min-height: 100%; z-index: -2; object-fit: cover; }
        .dark-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(12, 12, 14, 0.92); backdrop-filter: blur(5px); z-index: -1; }
        
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

        .glass-card { 
            background: #1e1e24; 
            border: 1px solid rgba(255,255,255,0.1); 
            border-radius: 14px; 
            padding: 26px; 
            margin-bottom: 24px; 
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }

        h2, h4 { color: #ffffff; font-weight: 700; margin-bottom: 14px; font-size: 1.35rem; }
        
        .step-box { 
            background: #141418; 
            border-radius: 10px; 
            padding: 16px; 
            border: 1px solid rgba(255,255,255,0.08); 
            font-family: 'Consolas', 'Courier New', monospace; 
            color: #d1d5db; 
            font-size: 0.88rem; 
            line-height: 1.6;
            max-height: 220px;
            overflow-y: auto;
        }

        .chart-container-card {
            background: #141418;
            border-radius: 10px;
            padding: 16px;
            border: 1px solid rgba(255,255,255,0.08);
            margin-bottom: 12px;
        }

        .btn-custom { background: #4ecdc4; color: #000; font-weight: 700; border-radius: 20px; padding: 10px 24px; font-size: 0.9rem; border: none; text-decoration: none; display: inline-block; }
        .btn-custom:hover { background: #2bd2a4; color: #000; }
        
        .btn-outline-custom { background-color: transparent; border: 1px solid rgba(255,255,255,0.25); color: #a0a5b5; border-radius: 16px; padding: 6px 16px; font-size: 0.85rem; text-decoration: none; display: inline-block; }
        .btn-outline-custom:hover { border-color: #ffe66d; color: #ffffff; }
        .table-dark { background-color: #141418; font-size: 0.9rem; }
        .table-dark th, .table-dark td { padding: 10px 12px; }
        .form-label { font-size: 0.88rem; margin-bottom: 6px; }
    </style>
</head>
<body>

    <video autoplay muted loop playsinline class="bg-video">
        <source src="${pageContext.request.contextPath}/videos/bgvideo.mp4" type="video/mp4">
    </video>
    <div class="dark-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-glass fixed-top">
        <div class="container">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/index.jsp"> OS SIMULATOR</a>
            <div class="ms-auto">
                <div class="navbar-nav">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/input.jsp">Process Input</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container col-lg-9 col-md-11">
        
        <!-- Calculated Results Table -->
        <div class="glass-card">
            <h2>Calculated Process Metrics</h2>
            <table class="table table-dark table-hover mt-3 align-middle text-center">
                <thead>
                    <tr>
                        <th>Process ID</th>
                        <th>Arrival Time</th>
                        <th>Burst Time</th>
                        <th>Waiting Time</th>
                        <th>Turnaround Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        @SuppressWarnings("unchecked")
                        List<Process> list = (List<Process>) session.getAttribute("dynProcesses");
                        if(list != null) {
                            for(Process p : list) {
                    %>
                    <tr>
                        <td><strong><%= p.getPid() %></strong></td>
                        <td><%= p.getArrivalTime() %> ms</td>
                        <td><%= p.getBurstTime() %> ms</td>
                        <td style="color: #00d2d3;"><%= p.getWaitingTime() %> ms</td>
                        <td style="color: #ffe66d;"><%= p.getTurnaroundTime() %> ms</td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>

            <div class="row my-3 text-center justify-content-center">
                <div class="col-md-5">
                    <div class="p-3 border border-secondary rounded background-dark">
                        <h6 class="mb-1" style="font-size: 0.9rem;">Average Waiting Time</h6>
                        <p class="fs-5 fw-bold mb-0" style="color: #00d2d3;"><%= session.getAttribute("avgDynWT") != null ? session.getAttribute("avgDynWT") : "0.00" %> ms</p>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="p-3 border border-secondary rounded background-dark">
                        <h6 class="mb-1" style="font-size: 0.9rem;">Average Turnaround Time</h6>
                        <p class="fs-5 fw-bold mb-0" style="color: #ffe66d;"><%= session.getAttribute("avgDynTAT") != null ? session.getAttribute("avgDynTAT") : "0.00" %> ms</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Steps -->
        <div class="glass-card">
            <h4>Calculation Steps</h4>
            <div class="step-box">
                <%
                    @SuppressWarnings("unchecked")
                    List<String> steps = (List<String>) session.getAttribute("dynSteps");
                    if(steps != null) {
                        for(String step : steps) {
                %>
                    <div><%= step %></div>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <!-- Gantt Chart -->
        <div class="glass-card">
            <h4>Gantt Chart</h4>
            <div class="chart-container-card">
                <canvas id="ganttChartBar" height="100"></canvas>
            </div>
        </div>

        <!-- Waiting & Turnaround Time Charts -->
        <div class="glass-card">
            <h4>Waiting Time Chart</h4>
            <div class="chart-container-card">
                <canvas id="dynWtChart" height="100"></canvas>
            </div>

            <h4 class="mt-4">Turnaround Time Chart</h4>
            <div class="chart-container-card">
                <canvas id="dynTatChart" height="100"></canvas>
            </div>
        </div>

        <!-- Navigation / Comparison -->
        <div class="glass-card text-center">
            <h4>Execute Original Traditional RR for Comparison</h4>
            <form action="${pageContext.request.contextPath}/OriginalRR" method="POST" class="mt-3 d-inline-block col-md-6 text-start">
                <div class="mb-3">
                    <label class="form-label text-white-50">Specify Fixed Time Quantum (ms):</label>
                    <input type="number" name="fixedTQ" class="form-control" required placeholder="e.g. 4" min="1">
                </div>
                <div class="text-center mt-3">
                    <button type="submit" class="btn btn-custom">Run Original RR & View Comparison</button>
                </div>
            </form>
        </div>

    </div>

    <script>
        const pLabels = [<%
            if(list != null) {
                for(int i=0; i<list.size(); i++) {
                    out.print("'" + list.get(i).getPid() + "'" + (i < list.size()-1 ? "," : ""));
                }
            }
        %>];

        const wtData = [<%
            if(list != null) {
                for(int i=0; i<list.size(); i++) {
                    out.print(list.get(i).getWaitingTime() + (i < list.size()-1 ? "," : ""));
                }
            }
        %>];

        const tatData = [<%
            if(list != null) {
                for(int i=0; i<list.size(); i++) {
                    out.print(list.get(i).getTurnaroundTime() + (i < list.size()-1 ? "," : ""));
                }
            }
        %>];

        <%
            @SuppressWarnings("unchecked")
            List<GanttSlot> slots = (List<GanttSlot>) session.getAttribute("dynGanttSlots");
        %>
        const ganttLabels = [<%
            if(slots != null) {
                for(int i=0; i<slots.size(); i++) {
                    out.print("'" + slots.get(i).getPid() + "'" + (i < slots.size()-1 ? "," : ""));
                }
            }
        %>];

        const ganttDurations = [<%
            if(slots != null) {
                for(int i=0; i<slots.size(); i++) {
                    int duration = slots.get(i).getEndTime() - slots.get(i).getStartTime();
                    out.print(duration + (i < slots.size()-1 ? "," : ""));
                }
            }
        %>];

        const barColors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#1b6ca8', '#53354a', '#6a2c70', '#e84545', '#900c3f'];

        new Chart(document.getElementById('ganttChartBar'), {
            type: 'bar',
            data: {
                labels: ganttLabels,
                datasets: [{
                    data: ganttDurations,
                    backgroundColor: ganttLabels.map((_, idx) => barColors[idx % barColors.length]),
                    borderRadius: 4
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    x: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#a0a5b5', font: { size: 11 } } },
                    y: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#a0a5b5', font: { size: 11 } }, beginAtZero: true }
                }
            }
        });

        new Chart(document.getElementById('dynWtChart'), {
            type: 'line',
            data: {
                labels: pLabels,
                datasets: [{ label: 'Waiting Time', data: wtData, borderColor: '#00d2d3', backgroundColor: 'rgba(0, 210, 211, 0.2)', fill: true, tension: 0.3 }]
            },
            options: {
                responsive: true,
                plugins: { legend: { labels: { color: '#ffffff', font: { size: 11 } } } },
                scales: {
                    x: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#a0a5b5', font: { size: 11 } } },
                    y: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#a0a5b5', font: { size: 11 } }, beginAtZero: true }
                }
            }
        });

        new Chart(document.getElementById('dynTatChart'), {
            type: 'line',
            data: {
                labels: pLabels,
                datasets: [{ label: 'Turnaround Time', data: tatData, borderColor: '#ffe66d', backgroundColor: 'rgba(255, 230, 109, 0.2)', fill: true, tension: 0.3 }]
            },
            options: {
                responsive: true,
                plugins: { legend: { labels: { color: '#ffffff', font: { size: 11 } } } },
                scales: {
                    x: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#a0a5b5', font: { size: 11 } } },
                    y: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#a0a5b5', font: { size: 11 } }, beginAtZero: true }
                }
            }
        });
    </script>
</body>
</html>