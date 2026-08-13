package com.company.api;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class PiiLogTest {

    @Test
    void testLogsDoNotExposePII() {
        String incomingApiPayload = "Patient Details: name=gajendra, dob=1998-04-04, mrn=MRN98765, email=gajendra@gmail.com, phone=9876543210";
        String sanitizedLog = LogSanitizer.maskLog(incomingApiPayload);

        assertFalse(sanitizedLog.contains("gajendra"), "FAILED: Patient Name leaked!");
        assertFalse(sanitizedLog.contains("1998-04-04"), "FAILED: DOB leaked!");
        assertFalse(sanitizedLog.contains("MRN98765"), "FAILED: MRN leaked!");
        assertFalse(sanitizedLog.contains("gajendra@gmail.com"), "FAILED: Email leaked!");
        assertFalse(sanitizedLog.contains("9876543210"), "FAILED: Phone leaked!");

        assertTrue(sanitizedLog.contains("[REDACTED]"), "Log should contain [REDACTED]");
    }
}