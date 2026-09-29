package main

# Block deployment if high or critical vulnerabilities exist
deny[msg] {
    input.vulnerabilities.critical > 0
    msg := "Security Policy Violation: Found critical vulnerabilities"
}

deny[msg] {
    input.vulnerabilities.high > 0
    msg := "Security Policy Violation: Found high vulnerabilities"
}