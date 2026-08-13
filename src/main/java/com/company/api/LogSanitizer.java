package com.company.api;

public class LogSanitizer {
    public static String maskLog(String rawLog) {
        if (rawLog == null) return "";
        return rawLog
            .replaceAll("(?i)(name\\s*=\\s*)[^,]+", "$1[REDACTED]")
            .replaceAll("(?i)(dob\\s*=\\s*)[^,]+", "$1[REDACTED]")
            .replaceAll("(?i)(mrn\\s*=\\s*)[^,]+", "$1[REDACTED]")
            .replaceAll("(?i)(email\\s*=\\s*)[^,]+", "$1[REDACTED]")
            .replaceAll("(?i)(phone\\s*=\\s*)[^,]+", "$1[REDACTED]");
    }
}