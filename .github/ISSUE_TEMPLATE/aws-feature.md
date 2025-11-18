---
name: AWS Feature Request
about: Propose a new AWS service or feature implementation
title: '[AWS] [SERVICE] '
labels: ['type:feature', 'needs-triage']
assignees: ''
---

## Feature Overview
<!-- Brief description of the AWS feature or service you want to implement -->

## AWS Service
<!-- Which AWS service(s) will be used? -->
- [ ] IAM
- [ ] VPC
- [ ] EC2
- [ ] ECS/Fargate
- [ ] Lambda
- [ ] S3
- [ ] RDS
- [ ] CloudWatch
- [ ] Route53
- [ ] ALB/NLB
- [ ] CloudFront
- [ ] Other: ___________

## Business Justification
<!-- Why is this feature needed? What problem does it solve? -->

## Technical Requirements

### Architecture
<!-- Describe the high-level architecture -->

### Resources Needed
<!-- List AWS resources to be created -->
-
-
-

### Dependencies
<!-- Any dependencies on other services or infrastructure? -->
-
-

## AWS Accounts
<!-- Which AWS account(s) will this be deployed to? -->
- [ ] Development
- [ ] Staging
- [ ] Production
- [ ] Management/Organization

## Security Considerations
<!-- Security implications, IAM policies needed, encryption requirements, etc. -->

### IAM Policies Required
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [],
      "Resource": []
    }
  ]
}
```

### Network Security
<!-- VPC, Security Groups, NACLs, etc. -->

### Data Classification
<!-- What type of data will this handle? -->
- [ ] Public
- [ ] Internal
- [ ] Confidential
- [ ] Restricted

## Cost Estimate
<!-- Estimated monthly cost in USD -->
- **Estimated Monthly Cost**: $___________
- **Cost Breakdown**:
  -
  -

## Implementation Plan

### Phase 1: Design
- [ ] Architecture diagram created
- [ ] Security review completed
- [ ] Cost approved
- [ ] Dependencies identified

### Phase 2: Development
- [ ] Infrastructure as Code (Terraform/CloudFormation) written
- [ ] Configuration files created
- [ ] Documentation updated
- [ ] Code review completed

### Phase 3: Testing
- [ ] Deployed to Dev environment
- [ ] Unit tests passed
- [ ] Integration tests passed
- [ ] Security scan completed

### Phase 4: Deployment
- [ ] Deployed to Staging
- [ ] Smoke tests passed
- [ ] Deployed to Production
- [ ] Monitoring configured

## Monitoring & Alerts
<!-- What CloudWatch metrics and alarms should be set up? -->

### Metrics to Track
-
-

### Alerts Needed
-
-

## Rollback Plan
<!-- How to rollback if something goes wrong? -->

## Documentation
<!-- Links to relevant documentation, ADRs, or design docs -->
-
-

## Additional Context
<!-- Any other information, screenshots, diagrams, etc. -->

## Acceptance Criteria
<!-- What does "done" look like? -->
- [ ]
- [ ]
- [ ]

## Effort Estimate
<!-- Story points or time estimate -->
- **Story Points**: ___________
- **Time Estimate**: ___________ days

## Priority
- [ ] P0 - Critical (Production blocker)
- [ ] P1 - High (Important feature)
- [ ] P2 - Medium (Standard work)
- [ ] P3 - Low (Nice to have)
