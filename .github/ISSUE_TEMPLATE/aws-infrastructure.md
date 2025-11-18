---
name: AWS Infrastructure Change
about: Track infrastructure changes, migrations, or updates
title: '[INFRA] [SERVICE] '
labels: ['type:infrastructure', 'needs-triage']
assignees: ''
---

## Infrastructure Change Overview
<!-- Brief description of the infrastructure change -->

## Change Type
- [ ] New Infrastructure
- [ ] Configuration Update
- [ ] Migration
- [ ] Scaling/Capacity Change
- [ ] Decommission/Cleanup
- [ ] Cost Optimization
- [ ] Performance Improvement

## Affected AWS Services
<!-- List all AWS services that will be affected -->
-
-
-

## Affected Environments
- [ ] Development
- [ ] Staging
- [ ] Production
- [ ] All Environments

## Change Justification
<!-- Why is this infrastructure change needed? -->

## Current State
<!-- Describe the current infrastructure setup -->

### Current Architecture
```
<!-- Diagram or description of current state -->
```

### Current Configuration
<!-- Key configuration details -->

## Target State
<!-- Describe the desired infrastructure state -->

### Target Architecture
```
<!-- Diagram or description of target state -->
```

### Target Configuration
<!-- Key configuration details -->

## Impact Analysis

### Services Affected
<!-- Which applications or services will be impacted? -->
-
-

### Downtime Required
- [ ] No downtime
- [ ] Planned maintenance window
- [ ] Rolling update
- **Estimated Downtime**: ___________ minutes

### User Impact
<!-- How will users be affected? -->

### Data Impact
<!-- Will any data be migrated or modified? -->
- [ ] No data impact
- [ ] Data migration required
- [ ] Data backup required
- **Data Size**: ___________

## Technical Details

### Infrastructure as Code
<!-- Will this use Terraform, CloudFormation, CDK, etc.? -->
- **Tool**: ___________
- **Repository**: ___________
- **Path**: ___________

### Configuration Changes
<!-- List specific configuration changes -->
```yaml
# Before
key: old_value

# After
key: new_value
```

### Resource Changes
<!-- List resources to be created, modified, or deleted -->

#### To Create
-
-

#### To Modify
-
-

#### To Delete
-
-

## Security Review

### Security Impact
<!-- How does this change affect security? -->

### IAM Changes
<!-- Any IAM policy or role changes? -->
```json
{
  "PolicyChanges": "..."
}
```

### Network Changes
<!-- VPC, subnet, security group, or routing changes? -->

### Compliance
- [ ] Complies with security policies
- [ ] No sensitive data exposure
- [ ] Encryption maintained/improved
- [ ] Audit logging configured

## Cost Impact
<!-- How will this affect AWS costs? -->
- **Current Monthly Cost**: $___________
- **Projected Monthly Cost**: $___________
- **Net Change**: $___________
- **Cost Justification**: ___________

## Risk Assessment
<!-- What could go wrong? -->

### Risks
| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
|      |        |             |            |
|      |        |             |            |

### Risk Level
- [ ] Low Risk
- [ ] Medium Risk
- [ ] High Risk

## Implementation Plan

### Pre-requisites
- [ ] Backup completed
- [ ] Change request approved
- [ ] Stakeholders notified
- [ ] Maintenance window scheduled (if needed)

### Implementation Steps
1. [ ] Step 1
2. [ ] Step 2
3. [ ] Step 3
4. [ ] Verification
5. [ ] Monitoring check

### Rollback Plan
<!-- Detailed steps to rollback if needed -->
1.
2.
3.

**Rollback Time Estimate**: ___________ minutes

## Testing Plan

### Pre-Deployment Testing
- [ ] Infrastructure code validated
- [ ] Dry-run in Dev environment
- [ ] Security scan completed
- [ ] Cost estimate verified

### Post-Deployment Testing
- [ ] Health checks passed
- [ ] Integration tests passed
- [ ] Performance metrics normal
- [ ] No error spikes in logs

## Monitoring

### Metrics to Watch
<!-- Key CloudWatch metrics to monitor during and after change -->
-
-
-

### Alarms to Configure
-
-

### Dashboard Updates
<!-- Which dashboards need to be updated? -->
-
-

## Communication Plan

### Notification Timeline
- **T-7 days**: Stakeholder notification
- **T-3 days**: Technical team briefing
- **T-1 day**: Final confirmation
- **T-0**: Change implementation
- **T+1 hour**: Status update
- **T+24 hours**: Post-implementation review

### Stakeholders to Notify
-
-
-

## Documentation Updates
<!-- Which documentation needs to be updated? -->
- [ ] Architecture diagrams
- [ ] Runbooks
- [ ] Configuration documentation
- [ ] Team wiki
- [ ] README files

## Acceptance Criteria
<!-- What needs to be true for this change to be considered successful? -->
- [ ] All resources deployed successfully
- [ ] No errors in application logs
- [ ] Performance metrics within acceptable range
- [ ] All tests passing
- [ ] Documentation updated
- [ ] Team trained (if needed)

## Timeline
- **Planned Start**: ___________
- **Planned Completion**: ___________
- **Total Duration**: ___________ days

## Priority
- [ ] P0 - Critical (Urgent/Emergency)
- [ ] P1 - High (Next sprint)
- [ ] P2 - Medium (Upcoming quarter)
- [ ] P3 - Low (Backlog)

## Additional Notes
<!-- Any other relevant information -->
