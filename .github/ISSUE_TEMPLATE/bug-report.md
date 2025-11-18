---
name: Bug Report
about: Report a bug or issue in the AWS infrastructure or application
title: '[BUG] [SERVICE] '
labels: ['type:bug', 'needs-triage']
assignees: ''
---

## Bug Description
<!-- Clear and concise description of the bug -->

## Affected AWS Service
<!-- Which AWS service is experiencing the issue? -->
- [ ] IAM
- [ ] VPC
- [ ] EC2
- [ ] ECS/Fargate
- [ ] Lambda
- [ ] S3
- [ ] RDS
- [ ] CloudWatch
- [ ] Application Service
- [ ] Other: ___________

## Environment
- **AWS Account**: ___________ (Dev/Staging/Prod)
- **Region**: ___________
- **Service/Application**: ___________
- **Version/Commit**: ___________

## Severity
- [ ] Critical - Production down
- [ ] High - Major functionality broken
- [ ] Medium - Functionality impaired
- [ ] Low - Minor issue

## Steps to Reproduce
<!-- Provide detailed steps to reproduce the issue -->
1.
2.
3.
4.

## Expected Behavior
<!-- What should happen? -->

## Actual Behavior
<!-- What actually happens? -->

## Screenshots/Logs
<!-- If applicable, add screenshots or log excerpts -->

### Error Messages
```
Paste error messages here
```

### CloudWatch Logs
```
Paste relevant log entries here
```

### AWS Console Screenshots
<!-- Attach screenshots if helpful -->

## Impact

### Users Affected
- **Number of users**: ___________
- **User groups**: ___________

### Services Affected
<!-- Which services or features are impacted? -->
-
-

### Business Impact
<!-- How does this affect business operations? -->

## Frequency
- [ ] Happens always
- [ ] Happens intermittently
- [ ] Happened once
- **Frequency**: ___________ % of requests/operations

## When Did This Start?
- **First Observed**: ___________
- **Recent Changes**: ___________ (Any deployments or changes around this time?)

## Diagnostic Information

### AWS Resource IDs
```
Instance IDs:
Container IDs:
Task ARNs:
Function Names:
```

### CloudWatch Metrics
<!-- Any relevant metric data? -->
```
Metric: CPUUtilization
Value: 98%
Time: 2025-01-15 14:30 UTC
```

### X-Ray Traces
<!-- Link to X-Ray traces if available -->
- **Trace ID**: ___________
- **Link**: ___________

### Recent Deployments
<!-- Any recent deployments or infrastructure changes? -->
- **Deployment Time**: ___________
- **Changes**: ___________

## Troubleshooting Already Done
<!-- What have you already tried? -->
- [ ] Checked CloudWatch logs
- [ ] Reviewed CloudWatch metrics
- [ ] Checked AWS console
- [ ] Restarted service
- [ ] Reviewed recent changes
- [ ] Checked AWS Service Health Dashboard
- [ ] Other: ___________

### Results
<!-- What did you find from troubleshooting? -->

## Possible Root Cause
<!-- If you have any hypothesis about the cause -->

## Workaround
<!-- Is there a temporary workaround? -->
- [ ] Yes
- [ ] No

**Workaround Description**: ___________

## Related Issues
<!-- Link to any related issues -->
-
-

## Additional Context
<!-- Any other information that might be helpful -->

## Priority Justification
<!-- Why this priority level? -->

## Proposed Solution
<!-- If you have ideas on how to fix this -->
