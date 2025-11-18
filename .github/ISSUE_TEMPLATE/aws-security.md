---
name: AWS Security Issue
about: Track security vulnerabilities, compliance issues, or security improvements
title: '[SECURITY] [SERVICE] '
labels: ['type:security', 'priority:high', 'needs-triage']
assignees: ''
---

## Security Issue Overview
<!-- Brief description of the security issue or improvement -->

## Issue Type
- [ ] Vulnerability
- [ ] Compliance Gap
- [ ] Security Enhancement
- [ ] Audit Finding
- [ ] Incident Response
- [ ] Access Control Issue
- [ ] Data Protection Issue

## Severity
- [ ] Critical - Immediate action required
- [ ] High - Fix within 24-48 hours
- [ ] Medium - Fix within 1 week
- [ ] Low - Fix within next sprint
- [ ] Informational

## Affected AWS Services
<!-- List all affected AWS services -->
-
-
-

## Affected Environments
- [ ] Development
- [ ] Staging
- [ ] Production
- [ ] All Environments

## Security Issue Details

### Description
<!-- Detailed description of the security issue -->

### Discovery Method
- [ ] Security scan
- [ ] AWS Security Hub
- [ ] AWS GuardDuty
- [ ] Manual audit
- [ ] Penetration test
- [ ] User report
- [ ] Other: ___________

### Vulnerability Details
<!-- If this is a vulnerability, provide details -->
- **CVE ID**: ___________
- **CVSS Score**: ___________
- **Attack Vector**: ___________
- **Exploitability**: ___________

### Current Risk
<!-- What is the current security risk? -->

### Potential Impact
- [ ] Data breach
- [ ] Unauthorized access
- [ ] Service disruption
- [ ] Compliance violation
- [ ] Financial loss
- [ ] Reputation damage

## Affected Resources

### AWS Resources
<!-- List specific AWS resources affected -->
- **Account ID**: ___________
- **Region**: ___________
- **Resources**:
  -
  -

### Data Affected
- **Data Classification**:
  - [ ] Public
  - [ ] Internal
  - [ ] Confidential
  - [ ] Restricted/PII
- **Records Affected**: ___________
- **Data Types**: ___________

## Current Configuration
<!-- Show the current insecure configuration -->

### IAM Policies
```json
{
  "Current": "policy-here"
}
```

### Security Group Rules
```json
{
  "Current": "rules-here"
}
```

### Other Configuration
```
Current configuration details
```

## Compliance Impact

### Frameworks Affected
- [ ] SOC 2
- [ ] ISO 27001
- [ ] PCI DSS
- [ ] HIPAA
- [ ] GDPR
- [ ] AWS Well-Architected
- [ ] CIS Benchmarks
- [ ] Other: ___________

### Specific Requirements
<!-- Which specific controls or requirements are violated? -->
-
-

## Remediation Plan

### Recommended Solution
<!-- Describe the recommended fix -->

### Target Configuration
<!-- Show the secure configuration -->

#### IAM Policies
```json
{
  "Recommended": "policy-here"
}
```

#### Security Group Rules
```json
{
  "Recommended": "rules-here"
}
```

#### Other Configuration
```
Recommended configuration details
```

### Alternative Solutions
<!-- Any alternative approaches? -->
1.
2.

### Implementation Steps
1. [ ] Backup current configuration
2. [ ] Test fix in Dev environment
3. [ ] Security review of fix
4. [ ] Apply to Staging
5. [ ] Verify fix effectiveness
6. [ ] Apply to Production
7. [ ] Confirm resolution
8. [ ] Update documentation

## Testing & Validation

### Security Tests Required
- [ ] Vulnerability scan
- [ ] Penetration test
- [ ] Access control verification
- [ ] Encryption verification
- [ ] Audit log verification
- [ ] Compliance scan

### Validation Criteria
<!-- How will you verify the issue is fixed? -->
-
-

## Immediate Actions (If Critical)

### Containment
<!-- What needs to be done immediately to contain the issue? -->
- [ ] Revoke access
- [ ] Block traffic
- [ ] Disable service
- [ ] Rotate credentials
- [ ] Enable additional logging

### Temporary Mitigations
<!-- Any temporary measures while working on permanent fix? -->
-
-

## Root Cause Analysis
<!-- Why did this security issue occur? -->

### Root Causes
-
-

### Contributing Factors
-
-

## Preventive Measures
<!-- How can we prevent this in the future? -->

### Process Improvements
-
-

### Technical Controls
- [ ] Enable AWS Config rule
- [ ] Add Security Hub check
- [ ] Implement CloudWatch alarm
- [ ] Add automated scan
- [ ] Other: ___________

### Detection Improvements
<!-- How can we detect similar issues faster? -->
-
-

## Monitoring & Alerts

### CloudWatch Alarms
<!-- What alarms should be configured? -->
-
-

### Security Hub Findings
<!-- Which Security Hub findings should be enabled? -->
-
-

### GuardDuty
<!-- Any GuardDuty findings to monitor? -->
-
-

## Communication

### Internal Notification
- [ ] Security team notified
- [ ] Management notified
- [ ] Development team notified
- [ ] Operations team notified

### External Notification Required?
- [ ] No external notification needed
- [ ] Customer notification required
- [ ] Regulatory notification required
- [ ] Partner notification required

### Timeline for Disclosure
<!-- If disclosure is needed, when? -->
- **Internal disclosure**: ___________
- **External disclosure**: ___________

## Incident Response (If applicable)

### Incident Timeline
| Time | Event |
|------|-------|
|      |       |
|      |       |

### Evidence Collection
- [ ] Logs collected
- [ ] Screenshots captured
- [ ] Configuration exported
- [ ] Network captures obtained

### Forensics Required?
- [ ] Yes
- [ ] No

## Documentation

### Documentation Updates Needed
- [ ] Security policies
- [ ] Runbooks
- [ ] Architecture diagrams
- [ ] Security baseline
- [ ] Training materials

### Lessons Learned
<!-- Document lessons learned for post-incident review -->
-
-

## Cost Impact
<!-- Any cost implications of the fix? -->
- **Implementation Cost**: $___________
- **Ongoing Cost Change**: $___________
- **Cost of Not Fixing**: $___________

## Dependencies
<!-- Any dependencies or blockers? -->
-
-

## Acceptance Criteria
<!-- What needs to be true for this to be considered resolved? -->
- [ ] Vulnerability no longer exists
- [ ] Security scans pass
- [ ] Compliance requirements met
- [ ] Monitoring in place
- [ ] Documentation updated
- [ ] Team trained
- [ ] Post-incident review completed (if applicable)

## Timeline
- **Discovered**: ___________
- **Must Fix By**: ___________
- **Target Resolution**: ___________

## Additional Resources
<!-- Links to relevant documentation, security advisories, etc. -->
-
-

## Additional Notes
<!-- Any other relevant information -->
