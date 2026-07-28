package com.scheduler;

import java.io.IOException;
import java.io.Serializable;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DynamicRR")
public class DynamicRR extends HttpServlet {
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/input.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String numStr = request.getParameter("num");
            if (numStr == null || numStr.trim().isEmpty()) {
                numStr = request.getParameter("numProcesses");
            }

            if (numStr == null || numStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/input.jsp");
                return;
            }

            int n = Integer.parseInt(numStr.trim());
            List<com.scheduler.Process> processList = new ArrayList<>();

            for (int i = 1; i <= n; i++) {
                String pid = request.getParameter("pid" + i);
                if (pid == null)
                    pid = request.getParameter("processName" + i);
                if (pid == null)
                    pid = request.getParameter("pid_" + i);

                String arrStr = request.getParameter("arrival" + i);
                if (arrStr == null)
                    arrStr = request.getParameter("arrivalTime" + i);
                if (arrStr == null)
                    arrStr = request.getParameter("arrival_" + i);

                String burstStr = request.getParameter("burst" + i);
                if (burstStr == null)
                    burstStr = request.getParameter("burstTime" + i);
                if (burstStr == null)
                    burstStr = request.getParameter("burst_" + i);

                if (pid == null || pid.trim().isEmpty()) {
                    pid = "P" + i;
                }

                int arrival = 0;
                if (arrStr != null && !arrStr.trim().isEmpty()) {
                    arrival = Integer.parseInt(arrStr.trim());
                }

                int burst = 1;
                if (burstStr != null && !burstStr.trim().isEmpty()) {
                    burst = Integer.parseInt(burstStr.trim());
                }

                com.scheduler.Process proc = new com.scheduler.Process(pid.trim(), arrival, burst);
                proc.reset();
                processList.add(proc);
            }

            List<GanttSlot> ganttChart = new ArrayList<>();
            List<String> steps = new ArrayList<>();

            List<Integer> burstList = new ArrayList<>();
            for (com.scheduler.Process p : processList) {
                burstList.add(p.getBurstTime());
                p.setRemainingBT(p.getBurstTime());
                p.setCyclesWaited(0);
                p.setTempPriority(0);
                p.setPermPriority(0);
                p.setCompleted(false);
            }

            Collections.sort(burstList);
            double median = (n % 2 == 0)
                    ? (burstList.get(n / 2 - 1) + burstList.get(n / 2)) / 2.0
                    : burstList.get(n / 2);

            int btMin = Collections.min(burstList);
            int btMax = Collections.max(burstList);
            int tq = (int) Math.round(median + ((double) (btMax - btMin) / n));
            if (tq <= 0)
                tq = 1;

            steps.add("THAS-RR Started with Dynamic User Data. Initial TQ = " + tq + " ms");

            int time = 0;
            int completedCount = 0;
            int cycle = 0;

            while (completedCount < n) {
                List<com.scheduler.Process> readyQueue = new ArrayList<>();

                for (com.scheduler.Process p : processList) {
                    if (!p.isCompleted() && p.getArrivalTime() <= time) {
                        readyQueue.add(p);
                    }
                }

                if (readyQueue.isEmpty()) {
                    int nextArrival = Integer.MAX_VALUE;
                    for (com.scheduler.Process p : processList) {
                        if (!p.isCompleted() && p.getArrivalTime() > time) {
                            nextArrival = Math.min(nextArrival, p.getArrivalTime());
                        }
                    }
                    if (nextArrival != Integer.MAX_VALUE) {
                        ganttChart.add(new GanttSlot("IDLE", time, nextArrival));
                        steps.add("Time [" + time + " ms - " + nextArrival + " ms]: CPU IDLE");
                        time = nextArrival;
                    } else {
                        time++;
                    }
                    continue;
                }

                double avgBT = readyQueue.stream().mapToInt(com.scheduler.Process::getRemainingBT).average()
                        .orElse(0.0);
                for (com.scheduler.Process p : readyQueue) {
                    p.setTempPriority(p.getRemainingBT() < avgBT ? 1 : 0);
                    if (p.getCyclesWaited() >= 2) {
                        p.setPermPriority(p.getPermPriority() + 1);
                        p.setCyclesWaited(0);
                    }
                }

                com.scheduler.Process selected = null;
                int highestPriority = -1;

                for (com.scheduler.Process p : readyQueue) {
                    int totalPriority = p.getTempPriority() + p.getPermPriority();
                    if (selected == null || totalPriority > highestPriority ||
                            (totalPriority == highestPriority && p.getRemainingBT() < selected.getRemainingBT())) {
                        selected = p;
                        highestPriority = totalPriority;
                    }
                }

                if (selected != null) {
                    int runTime = Math.min(tq, selected.getRemainingBT());
                    int startTime = time;
                    time += runTime;
                    selected.setRemainingBT(selected.getRemainingBT() - runTime);

                    ganttChart.add(new GanttSlot(selected.getPid(), startTime, time));
                    steps.add("Time [" + startTime + " ms - " + time + " ms]: Executing " + selected.getPid()
                            + " (Remaining BT: " + selected.getRemainingBT() + " ms)");

                    for (com.scheduler.Process p : readyQueue) {
                        if (!p.getPid().equals(selected.getPid())) {
                            p.setCyclesWaited(p.getCyclesWaited() + 1);
                        }
                    }

                    if (selected.getRemainingBT() == 0) {
                        selected.setCompletionTime(time);
                        selected.setTurnaroundTime(selected.getCompletionTime() - selected.getArrivalTime());
                        selected.setWaitingTime(selected.getTurnaroundTime() - selected.getBurstTime());
                        selected.setCompleted(true);
                        completedCount++;
                        steps.add("  --> Process " + selected.getPid() + " COMPLETED at " + time + " ms");
                    }

                    cycle++;

                    if (cycle % (2 * n) == 0) {
                        int activeCount = 0;
                        int remainingSum = 0;
                        boolean hasLargeBT = false;

                        for (com.scheduler.Process p : processList) {
                            if (!p.isCompleted()) {
                                activeCount++;
                                remainingSum += p.getRemainingBT();
                                if (p.getRemainingBT() > tq) {
                                    hasLargeBT = true;
                                }
                            }
                        }

                        if (activeCount >= 2 && hasLargeBT) {
                            double avgRemainingBT = (double) remainingSum / activeCount;
                            double log2Val = Math.log(activeCount + 2) / Math.log(2);
                            int newTQ = (int) Math.round(avgRemainingBT / log2Val);

                            if (newTQ > 0) {
                                tq = newTQ;
                                steps.add("• Dynamic TQ Recalculated: " + tq + " ms");
                            }
                        }
                    }
                }
            }

            int totalWT = 0;
            int totalTAT = 0;
            for (com.scheduler.Process p : processList) {
                totalWT += p.getWaitingTime();
                totalTAT += p.getTurnaroundTime();
            }

            double avgWT = (double) totalWT / n;
            double avgTAT = (double) totalTAT / n;
            double throughput = (time > 0) ? (double) n / time : 0.0;

            HttpSession session = request.getSession();
            session.setAttribute("num", n);
            session.setAttribute("dynProcesses", processList);
            session.setAttribute("dynGanttSlots", ganttChart);
            session.setAttribute("dynSteps", steps);
            session.setAttribute("avgDynWT", String.format(Locale.US, "%.2f", avgWT));
            session.setAttribute("avgDynTAT", String.format(Locale.US, "%.2f", avgTAT));
            session.setAttribute("dynThroughput", String.format(Locale.US, "%.2f", throughput));

            response.sendRedirect(request.getContextPath() + "/result.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/input.jsp?error=invalid_input");
        }
    }
}