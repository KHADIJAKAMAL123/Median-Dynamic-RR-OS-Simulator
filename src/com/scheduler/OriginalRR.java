package com.scheduler;

import java.io.IOException;
import java.io.Serializable;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/OriginalRR")
public class OriginalRR extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static class GanttSlot implements Serializable {
        private static final long serialVersionUID = 1L;
        private String pid;
        private int startTime;
        private int endTime;

        public GanttSlot(String pid, int startTime, int endTime) {
            this.pid = pid;
            this.startTime = startTime;
            this.endTime = endTime;
        }

        public String getPid() {
            return pid;
        }

        public int getStartTime() {
            return startTime;
        }

        public int getEndTime() {
            return endTime;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            @SuppressWarnings("unchecked")
            List<com.scheduler.Process> originalInput = (List<com.scheduler.Process>) session
                    .getAttribute("dynProcesses");

            if (originalInput == null || originalInput.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/input.jsp");
                return;
            }

            int fixedTQ = Integer.parseInt(request.getParameter("fixedTQ"));
            int n = originalInput.size();

            // Perform clean deep-copy and explicit state reset for Traditional RR
            // calculation
            List<com.scheduler.Process> processList = new ArrayList<>();
            for (com.scheduler.Process p : originalInput) {
                com.scheduler.Process cleanProc = new com.scheduler.Process(p.getPid(), p.getArrivalTime(),
                        p.getBurstTime());
                cleanProc.reset();
                processList.add(cleanProc);
            }

            Queue<com.scheduler.Process> readyQueue = new LinkedList<>();
            List<GanttSlot> ganttChart = new ArrayList<>();
            List<String> steps = new ArrayList<>();

            int currentTime = 0, completedCount = 0;
            boolean[] visited = new boolean[n];

            steps.add("• Traditional Round Robin Initialized with Fixed TQ: " + fixedTQ + " ms");

            for (int i = 0; i < n; i++) {
                com.scheduler.Process p = processList.get(i);
                if (p.getArrivalTime() <= currentTime && !visited[i]) {
                    readyQueue.add(p);
                    visited[i] = true;
                }
            }

            while (completedCount < n) {
                if (readyQueue.isEmpty()) {
                    int nextArrival = Integer.MAX_VALUE;
                    for (int i = 0; i < n; i++) {
                        com.scheduler.Process p = processList.get(i);
                        if (!p.isCompleted() && !visited[i]) {
                            nextArrival = Math.min(nextArrival, p.getArrivalTime());
                        }
                    }
                    if (nextArrival != Integer.MAX_VALUE) {
                        currentTime = nextArrival;
                        for (int i = 0; i < n; i++) {
                            com.scheduler.Process p = processList.get(i);
                            if (p.getArrivalTime() <= currentTime && !visited[i] && !p.isCompleted()) {
                                readyQueue.add(p);
                                visited[i] = true;
                            }
                        }
                    } else {
                        currentTime++;
                    }
                    continue;
                }

                com.scheduler.Process current = readyQueue.poll();
                int execTime = Math.min(fixedTQ, current.getRemainingBT());
                int startExec = currentTime;

                currentTime += execTime;
                ganttChart.add(new GanttSlot(current.getPid(), startExec, currentTime));
                current.setRemainingBT(current.getRemainingBT() - execTime);

                steps.add("• Time [" + startExec + " ms - " + currentTime + " ms]: Executing "
                        + current.getPid() + " (Remaining Burst: " + current.getRemainingBT() + " ms)");

                for (int i = 0; i < n; i++) {
                    com.scheduler.Process p = processList.get(i);
                    if (p.getArrivalTime() <= currentTime && !visited[i] && !p.isCompleted()) {
                        readyQueue.add(p);
                        visited[i] = true;
                    }
                }

                if (current.getRemainingBT() == 0) {
                    current.setCompletionTime(currentTime);
                    current.setTurnaroundTime(current.getCompletionTime() - current.getArrivalTime());
                    current.setWaitingTime(current.getTurnaroundTime() - current.getBurstTime());
                    current.setCompleted(true);
                    completedCount++;
                    steps.add("  --> Process " + current.getPid() + " COMPLETED at " + currentTime + " ms");
                } else {
                    readyQueue.add(current);
                }
            }

            int totalWT = 0, totalTAT = 0;
            for (com.scheduler.Process p : processList) {
                totalWT += p.getWaitingTime();
                totalTAT += p.getTurnaroundTime();
            }

            double avgWT = (double) totalWT / n;
            double avgTAT = (double) totalTAT / n;
            double throughput = (currentTime > 0) ? (double) n / currentTime : 0.0;

            session.setAttribute("fixedTQ", fixedTQ);
            session.setAttribute("origProcesses", processList);
            session.setAttribute("origGanttSlots", ganttChart);
            session.setAttribute("origSteps", steps);
            session.setAttribute("avgOrigWT", String.format(Locale.US, "%.2f", avgWT));
            session.setAttribute("avgOrigTAT", String.format(Locale.US, "%.2f", avgTAT));
            session.setAttribute("origThroughput", String.format(Locale.US, "%.2f", throughput));

            response.sendRedirect(request.getContextPath() + "/result_original.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/input.jsp?error=invalid_input");
        }
    }
}