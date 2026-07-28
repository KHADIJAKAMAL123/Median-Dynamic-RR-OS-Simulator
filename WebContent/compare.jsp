<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.scheduler.Process" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Algorithm Architecture & Comparative Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { 
            background: #121212; 
            color: #fff; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            padding-top: 80px; 
            padding-bottom: 50px; 
        }
        .bg-video { position: fixed; right: 0; bottom: 0; min-width: 100%; min-height: 100%; z-index: -2; object-fit: cover; }
        .dark-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(12, 12, 14, 0.92); backdrop-filter: blur(5px); z-index: -1; }
        
        .navbar-glass { background: rgba(20, 20, 22, 0.85); backdrop-filter: blur(14px); border-bottom: 1px solid rgba(255, 255, 255, 0.1); padding: 10px 0; }
        .navbar-brand { color: #ffe66d !important; font-weight: 700; font-size: 1.1rem; }
        .nav-link { color: #ffffff !important; margin: 0 8px; font-size: 0.9rem; }

        .glass-card { 
            background: #1e1e24; 
            border: 1px solid rgba(255,255,255,0.1); 
            border-radius: 12px; 
            padding: 24px; 
            margin-bottom: 20px; 
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
        }

        .page-title { color: #ffe66d; font-weight: 700; font-size: 1.35rem; text-align: center; margin-bottom: 8px; }
        .subtitle { color: #a0a5b5; text-align: center; font-size: 0.85rem; max-width: 750px; margin: 0 auto 20px auto; line-height: 1.4; }
        
        .principle-box { 
            background: #141418; 
            border: 1px solid rgba(255,255,255,0.08); 
            border-radius: 8px; 
            padding: 14px; 
            height: 100%; 
        }
        .principle-title { color: #ffe66d; font-weight: 600; font-size: 0.92rem; margin-bottom: 4px; }
        .principle-desc { color: #a0a5b5; font-size: 0.82rem; line-height: 1.4; margin: 0; }
        
        .chart-box { 
            background: #141418; 
            border: 1px solid rgba(255,255,255,0.08); 
            border-radius: 8px; 
            padding: 14px; 
            text-align: center; 
        }
        .chart-title { font-weight: 600; font-size: 0.88rem; margin-bottom: 10px; }
        
        .section-header { color: #ffe66d; font-size: 1rem; font-weight: 700; margin-top: 12px; margin-bottom: 12px; }
        
        .table-dark { background-color: #141418; font-size: 0.85rem; }
        .table-dark th, .table-dark td { padding: 8px 12px; }
        
        .btn-custom { background: #4ecdc4; color: #000; font-weight: 700; border-radius: 20px; padding: 8px 20px; font-size: 0.85rem; border: none; text-decoration: none; display: inline-block; }
        .btn-custom:hover { background: #2bd2a4; color: #000; }
        
        .btn-outline-custom { background-color: transparent; border: 1px solid rgba(255,255,255,0.25); color: #a0a5b5; border-radius: 16px; padding: 5px 14px; font-size: 0.8rem; text-decoration: none; display: inline-block; }
        .btn-outline-custom:hover { border-color: #ffe66d; color: #ffffff; }
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
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/input.jsp">Process Input</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
            </div>
        </div>
    </nav>

    <div class="container col-lg-9 col-md-11">
        <div class="glass-card">
            
            <div class="d-flex justify-content-between align-items-center mb-3">
                <a href="${pageContext.request.contextPath}/result_original.jsp" class="btn-outline-custom">&larr; Back to Traditional RR</a>
                <a href="${pageContext.request.contextPath}/result.jsp" class="btn-outline-custom">Back to Dynamic RR &rarr;</a>
            </div>

            <h2 class="page-title">Algorithm Architecture & Comparative Dashboard</h2>
            <p class="subtitle">An intelligent dynamic quantum CPU scheduler engineered to eliminate process starvation, adapt dynamically to CPU/IO workloads, and optimize turnaround times.</p>

            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <div class="principle-box">
                        <div class="principle-title">1. Dynamic Initial TQ</div>
                        <p class="principle-desc">Initial Time Quantum is determined using statistical median of burst times combined with maximum and minimum burst spreads.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="principle-box">
                        <div class="principle-title">2. Anti-Starvation Rules</div>
                        <p class="principle-desc">Tracks cycles waited in ready queue. Processes remaining idle for extended periods receive temporary priority escalations.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="principle-box">
                        <div class="principle-title">3. Cyclic Recalculation</div>
                        <p class="principle-desc">Recalculates active time quantum dynamically every logarithmic cycle break based on remaining active process load.</p>
                    </div>
                </div>
            </div>

            <div class="section-header">Overall Average Metrics Comparison</div>
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <div class="chart-box">
                        <div class="chart-title" style="color: #00d2d3;">Average Waiting Time (ms)</div>
                        <div style="height: 180px;">
                            <canvas id="avgWtChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="chart-box">
                        <div class="chart-title" style="color: #1dd1a1;">Average Turnaround Time (ms)</div>
                        <div style="height: 180px;">
                            <canvas id="avgTatChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="section-header">Process-by-Process Waiting Time Comparison</div>
            <div class="chart-box mb-3">
                <div style="height: 200px;">
                    <canvas id="processCompareChart"></canvas>
                </div>
            </div>

            <div class="section-header">Detailed Process-Level Performance Table</div>
            <table class="table table-dark table-hover text-center align-middle">
                <thead>
                    <tr>
                        <th>Process ID</th>
                        <th style="color: #00d2d3;">Proposed Dynamic WT</th>
                        <th>Traditional Fixed WT</th>
                        <th style="color: #1dd1a1;">Proposed Dynamic TAT</th>
                        <th>Traditional Fixed TAT</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        @SuppressWarnings("unchecked")
                        List<Process> dynList = (List<Process>) session.getAttribute("dynProcesses");
                        @SuppressWarnings("unchecked")
                        List<Process> origList = (List<Process>) session.getAttribute("origProcesses");

                        if (dynList != null && origList != null) {
                            for (int i = 0; i < dynList.size(); i++) {
                                Process dp = dynList.get(i);
                                Process op = (i < origList.size()) ? origList.get(i) : null;
                    %>
                    <tr>
                        <td class="fw-bold"><%= dp.getPid() %></td>
                        <td style="color: #00d2d3; font-weight: 600;"><%= dp.getWaitingTime() %> ms</td>
                        <td class="text-white-50"><%= op != null ? op.getWaitingTime() + " ms" : "N/A" %></td>
                        <td style="color: #1dd1a1; font-weight: 600;"><%= dp.getTurnaroundTime() %> ms</td>
                        <td class="text-white-50"><%= op != null ? op.getTurnaroundTime() + " ms" : "N/A" %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-muted py-2">Please run both Dynamic and Original RR algorithms to populate comparative process data.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="p-2 px-3 rounded border border-secondary style-dark mt-3" style="background: #141418;">
                <h6 class="text-warning mb-1" style="font-size: 0.88rem;"> Performance Summary & Analytical Insight</h6>
                <p class="text-white-50 mb-0" style="font-size: 0.82rem; line-height: 1.4;">
                    The proposed <strong>Median Dynamic Round Robin</strong> algorithm outperforms traditional Round Robin by eliminating arbitrary fixed time quantums. Dynamic quantum adjustment minimizes context switching and prevents process starvation[cite: 18].
                </p>
            </div>

            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/input.jsp" class="btn-custom">Start New Simulation &rarr;</a>
            </div>

        </div>
    </div>

    <script>
        const avgDynWT = parseFloat('<%= session.getAttribute("avgDynWT") != null ? session.getAttribute("avgDynWT") : "0" %>') || 0;
        const avgOrigWT = parseFloat('<%= session.getAttribute("avgOrigWT") != null ? session.getAttribute("avgOrigWT") : "0" %>') || 0;
        const avgDynTAT = parseFloat('<%= session.getAttribute("avgDynTAT") != null ? session.getAttribute("avgDynTAT") : "0" %>') || 0;
        const avgOrigTAT = parseFloat('<%= session.getAttribute("avgOrigTAT") != null ? session.getAttribute("avgOrigTAT") : "0" %>') || 0;

        const pLabels = [<%
            if(dynList != null) {
                for(int i=0; i<dynList.size(); i++) {
                    out.print("'" + dynList.get(i).getPid() + "'" + (i < dynList.size()-1 ? "," : ""));
                }
            }
        %>];

        const dynWtData = [<%
            if(dynList != null) {
                for(int i=0; i<dynList.size(); i++) {
                    out.print(dynList.get(i).getWaitingTime() + (i < dynList.size()-1 ? "," : ""));
                }
            }
        %>];

        const origWtData = [<%
            if(origList != null) {
                for(int i=0; i<origList.size(); i++) {
                    out.print(origList.get(i).getWaitingTime() + (i < origList.size()-1 ? "," : ""));
                }
            }
        %>];

        new Chart(document.getElementById('avgWtChart'), {
            type: 'bar',
            data: {
                labels: ['Dynamic RR', 'Traditional Fixed RR'],
                datasets: [{ data: [avgDynWT, avgOrigWT], backgroundColor: ['#00d2d3', '#ffe66d'], borderRadius: 4 }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    x: { ticks: { color: '#a0a5b5', font: { size: 11 } }, grid: { color: 'rgba(255,255,255,0.05)' } },
                    y: { ticks: { color: '#a0a5b5', font: { size: 11 } }, grid: { color: 'rgba(255,255,255,0.05)' }, beginAtZero: true }
                }
            }
        });

        new Chart(document.getElementById('avgTatChart'), {
            type: 'bar',
            data: {
                labels: ['Dynamic RR', 'Traditional Fixed RR'],
                datasets: [{ data: [avgDynTAT, avgOrigTAT], backgroundColor: ['#1dd1a1', '#ffe66d'], borderRadius: 4 }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    x: { ticks: { color: '#a0a5b5', font: { size: 11 } }, grid: { color: 'rgba(255,255,255,0.05)' } },
                    y: { ticks: { color: '#a0a5b5', font: { size: 11 } }, grid: { color: 'rgba(255,255,255,0.05)' }, beginAtZero: true }
                }
            }
        });

        new Chart(document.getElementById('processCompareChart'), {
            type: 'bar',
            data: {
                labels: pLabels,
                datasets: [
                    { label: 'Proposed Dynamic WT (ms)', data: dynWtData, backgroundColor: '#00d2d3', borderRadius: 4 },
                    { label: 'Traditional Fixed WT (ms)', data: origWtData, backgroundColor: '#ffe66d', borderRadius: 4 }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { labels: { color: '#ffffff', font: { size: 11 } } } },
                scales: {
                    x: { ticks: { color: '#a0a5b5', font: { size: 11 } }, grid: { color: 'rgba(255,255,255,0.05)' } },
                    y: { ticks: { color: '#a0a5b5', font: { size: 11 } }, grid: { color: 'rgba(255,255,255,0.05)' }, beginAtZero: true }
                }
            }
        });
    </script>
</body>
</html>