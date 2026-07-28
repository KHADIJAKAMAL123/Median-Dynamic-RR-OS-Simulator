package com.scheduler;

import java.io.Serializable;

public class Process implements Serializable {
    private static final long serialVersionUID = 1L;

    private String pid;
    private int arrivalTime;
    private int burstTime;
    private int remainingBT;
    private int completionTime;
    private int turnaroundTime;
    private int waitingTime;
    private int tempPriority;
    private int permPriority;
    private int cyclesWaited;
    private boolean completed;

    public Process() {
    }

    public Process(String pid, int arrivalTime, int burstTime) {
        this.pid = pid;
        this.arrivalTime = arrivalTime;
        this.burstTime = burstTime;
        this.remainingBT = burstTime;
        this.completed = false;
        this.cyclesWaited = 0;
        this.tempPriority = 0;
        this.permPriority = 0;
    }

    public void reset() {
        this.remainingBT = this.burstTime;
        this.completionTime = 0;
        this.turnaroundTime = 0;
        this.waitingTime = 0;
        this.tempPriority = 0;
        this.permPriority = 0;
        this.cyclesWaited = 0;
        this.completed = false;
    }

    public String getPid() {
        return pid;
    }

    public int getArrivalTime() {
        return arrivalTime;
    }

    public int getBurstTime() {
        return burstTime;
    }

    public int getRemainingBT() {
        return remainingBT;
    }

    public int getCompletionTime() {
        return completionTime;
    }

    public int getTurnaroundTime() {
        return turnaroundTime;
    }

    public int getWaitingTime() {
        return waitingTime;
    }

    public int getTempPriority() {
        return tempPriority;
    }

    public int getPermPriority() {
        return permPriority;
    }

    public int getCyclesWaited() {
        return cyclesWaited;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public void setArrivalTime(int arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public void setBurstTime(int burstTime) {
        this.burstTime = burstTime;
        this.remainingBT = burstTime;
    }

    public void setRemainingBT(int remainingBT) {
        this.remainingBT = remainingBT;
    }

    public void setCompletionTime(int completionTime) {
        this.completionTime = completionTime;
    }

    public void setTurnaroundTime(int turnaroundTime) {
        this.turnaroundTime = turnaroundTime;
    }

    public void setWaitingTime(int waitingTime) {
        this.waitingTime = waitingTime;
    }

    public void setTempPriority(int tempPriority) {
        this.tempPriority = tempPriority;
    }

    public void setPermPriority(int permPriority) {
        this.permPriority = permPriority;
    }

    public void setCyclesWaited(int cyclesWaited) {
        this.cyclesWaited = cyclesWaited;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }
}