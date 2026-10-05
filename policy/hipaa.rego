package main

# Fail-Closed Rule: Missing or malformed vulnerabilities structure
deny contains msg if {
    not input.vulnerabilities
    msg := "POLICY VIOLATION: Vulnerabilities summary input is missing or malformed."
}

# Critical Vulnerabilities Policy Gate
deny contains msg if {
    input.vulnerabilities.critical > 0
    msg := sprintf("POLICY VIOLATION: Found %d CRITICAL vulnerabilities. Maximum allowed is 0.", [input.vulnerabilities.critical])
}

# High Vulnerabilities Policy Gate
deny contains msg if {
    input.vulnerabilities.high > 0
    msg := sprintf("POLICY VIOLATION: Found %d HIGH vulnerabilities. Maximum allowed is 0.", [input.vulnerabilities.high])
}