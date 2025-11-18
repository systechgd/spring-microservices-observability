# AWS Organization Development Workflow Guide

This guide describes the day-to-day workflows for using the GitHub Project for AWS organization development.

## Table of Contents
1. [Daily Workflows](#daily-workflows)
2. [Sprint/Iteration Workflows](#sprintiteration-workflows)
3. [AWS-Specific Workflows](#aws-specific-workflows)
4. [Emergency Workflows](#emergency-workflows)
5. [Review and Approval Workflows](#review-and-approval-workflows)
6. [Best Practices](#best-practices)

## Daily Workflows

### Morning Routine

#### 1. Check Your Active Work
```
1. Open project → "Team View" (grouped by Owner)
2. Review your "In Progress" items
3. Update status/comments from previous day
4. Check for any blockers
5. Move completed items to "In Review" or "Done"
```

#### 2. Review Blocked Items
```
1. Switch to Board view → "Blocked" column
2. Check if you can unblock any items
3. Add comments on progress
4. Tag people who can help unblock
```

#### 3. Plan Today's Work
```
1. Check "Ready" column
2. Pick highest priority items within your capacity
3. Assign to yourself
4. Move to "In Progress"
5. Start work
```

### Throughout the Day

#### When Starting New Work
```
1. Assign issue to yourself
2. Update "Sprint" field if using sprints
3. Add comment: "Starting work on this"
4. Create feature branch: feature/aws-[service]-[description]
5. Status automatically moves to "In Progress"
```

#### When Encountering Blockers
```
1. Add label "status:blocked"
2. Add comment explaining blocker
3. Tag relevant people
4. Link to blocking issue if exists
5. Pick up different work if possible
6. Item automatically moves to "Blocked" column
```

#### When Completing Work
```
1. Create pull request
2. Link PR to issue: "Closes #123"
3. Request review from team members
4. Item automatically moves to "In Review"
5. Add comment with testing notes
```

#### When Reviewing Others' Work
```
1. Check "In Review" column
2. Review PR and test changes
3. Approve or request changes
4. If approved and merged, close issue
5. Item moves to "Done"
```

### End of Day

#### Status Update
```
1. Add comments to in-progress items
2. Update % complete if using that metric
3. Flag any new blockers
4. Move completed items to appropriate columns
5. Brief standup note in issue comments
```

## Sprint/Iteration Workflows

### Sprint Planning (Every 2 Weeks)

#### Before Sprint Planning Meeting
```
1. Groom backlog
2. Add estimates (Effort field)
3. Clarify requirements
4. Update priorities
5. Identify dependencies
```

#### During Sprint Planning
```
1. Open "Planning Table" view
2. Review team velocity from last sprint
3. Review "Ready" column items
4. Discuss and estimate unclear items
5. Assign Sprint field to selected items
6. Assign owners
7. Document sprint goals in milestone
```

#### Sprint Planning Template
```markdown
## Sprint X Goals (Date Range: YYYY-MM-DD to YYYY-MM-DD)

### Sprint Objectives
- Objective 1
- Objective 2
- Objective 3

### Capacity
- Team Member 1: X points
- Team Member 2: Y points
- Total: Z points

### Selected Work
- [ ] #123 - High priority feature (5 points)
- [ ] #456 - Security fix (3 points)
- [ ] #789 - Infrastructure update (8 points)

### Dependencies
- External: ...
- Internal: ...

### Risks
- Risk 1
- Risk 2
```

### Daily Standup

#### Standup Format (Per Team Member)
```
1. Yesterday: [Update from issue comments]
2. Today: [Check "In Progress" items]
3. Blockers: [Check "Blocked" items]
```

#### During Standup
```
1. Open "Team View" or "Sprint View"
2. Each person reviews their items
3. Discuss blockers
4. Reassign work if needed
5. Update priorities if needed
```

### Sprint Review

#### End of Sprint
```
1. Filter items by Sprint field
2. Review completed items
3. Demo features to stakeholders
4. Gather feedback
5. Create follow-up issues
6. Archive or move incomplete items
```

#### Sprint Metrics to Review
```
- Planned vs Completed story points
- Velocity trend
- Number of blockers
- Cycle time per item
- Bug vs feature ratio
- Items carried over
```

### Sprint Retrospective

#### Retrospective Template
```markdown
## Sprint X Retrospective

### What Went Well ✅
-
-

### What Didn't Go Well ❌
-
-

### Action Items 🎯
- [ ] Action 1 (Owner: @person)
- [ ] Action 2 (Owner: @person)

### Metrics
- Velocity: X points
- Completed: Y items
- Carried over: Z items
```

## AWS-Specific Workflows

### Deploying New AWS Service

#### 1. Planning Phase
```
1. Create issue from "AWS Feature Request" template
2. Label: type:feature, aws:[service], env:[environment]
3. Fill all sections (especially security and cost)
4. Add to project in "Backlog"
5. Set Priority field
6. Get architecture review
7. Move to "Ready" when approved
```

#### 2. Development Phase
```
1. Assign to yourself
2. Create branch: feature/aws-[service]-[name]
3. Write Infrastructure as Code (Terraform/CloudFormation)
4. Document in issue comments
5. Cost estimate validation
6. Security policy review
7. Create PR with detailed description
```

#### 3. Testing Phase
```
1. Deploy to Dev environment
2. Run tests
3. Document test results in issue
4. Label: env:dev when deployed to dev
5. Request review
6. Deploy to Staging
7. Label: env:staging
8. Smoke tests
```

#### 4. Production Deployment
```
1. Schedule maintenance window if needed
2. Get approval from stakeholders
3. Create deployment checklist
4. Deploy to Production
5. Label: env:prod
6. Monitor metrics for 24 hours
7. Close issue after verification
```

#### 5. Post-Deployment
```
1. Update documentation
2. Configure monitoring
3. Set up alerts
4. Team knowledge sharing
5. Mark as Done
```

### Infrastructure Changes

#### Change Request Process
```
1. Create issue from "Infrastructure Change" template
2. Fill impact analysis
3. Document rollback plan
4. Get approvals (comment from approvers)
5. Schedule change window
6. Label: type:infrastructure
7. Add priority based on urgency
```

#### During Change Window
```
1. Add comment: "Change started at [time]"
2. Follow implementation steps from issue
3. Update progress in comments
4. Monitor metrics
5. Run verification tests
6. Add comment: "Change completed at [time]"
```

### Security Issues

#### Vulnerability Response
```
1. Create issue from "Security Issue" template
2. Label: type:security, priority based on severity
3. Fill vulnerability details
4. Assess impact
5. Immediate containment if critical
6. Develop fix
7. Test thoroughly
8. Deploy fix
9. Verify resolution
10. Document lessons learned
```

#### Security Review Process
```
1. All production changes need security review
2. Add label: needs-review
3. Tag security team member
4. Address feedback
5. Get approval before merging
6. Document security considerations
```

### Cost Management

#### Tracking Cost Changes
```
1. Use "Cost Impact" custom field
2. Monthly review of cost-impacting changes
3. Use "Cost Tracking" view
4. Label cost optimizations: cost:optimization
5. Track ROI on optimizations
```

#### Cost Optimization Workflow
```
1. Identify optimization opportunity
2. Create issue with cost analysis
3. Document current vs projected costs
4. Implement optimization
5. Monitor for 30 days
6. Document actual savings
7. Apply to other environments
```

## Emergency Workflows

### Production Incident

#### Immediate Response (First 5 Minutes)
```
1. Create issue: "[INCIDENT] [Brief description]"
2. Labels: type:bug, priority:critical, env:prod
3. Assign to on-call person
4. Add to project
5. Post in team chat
6. Start incident timeline in comments
```

#### During Incident
```
1. Update issue with timeline entries
2. Document all actions taken
3. Coordinate in issue comments
4. Track blockers
5. Update status regularly
6. Communicate to stakeholders
```

#### Post-Incident
```
1. Write postmortem in issue
2. Create follow-up issues for fixes
3. Update documentation
4. Team debrief
5. Close incident issue
6. Archive after 30 days
```

### Emergency Change

#### Process
```
1. Create issue with full impact analysis
2. Label: priority:critical
3. Get emergency approval (document in comments)
4. Follow change process with shorter timeline
5. Extra focus on rollback plan
6. Enhanced monitoring
7. Post-change review
```

## Review and Approval Workflows

### Code Review Process

#### Before Review
```
1. PR linked to issue
2. All tests passing
3. Description complete
4. Screenshots/demos if UI changes
5. Security scan passed
6. No merge conflicts
```

#### During Review
```
1. Check "In Review" column
2. Review code changes
3. Test in dev environment
4. Security review for prod changes
5. Approve or request changes
6. Comment on issue with review notes
```

#### After Review
```
1. Merge PR
2. Deploy to next environment
3. Verify deployment
4. Update issue status
5. Close issue when fully deployed
```

### Architecture Review

#### When Needed
```
- New AWS services
- Significant infrastructure changes
- Security architecture changes
- Cross-account changes
- Network changes
```

#### Process
```
1. Create architecture diagram
2. Document in issue
3. Tag architecture reviewers
4. Review meeting (if complex)
5. Address feedback
6. Get approval in comments
7. Move to "Ready"
```

### Change Advisory Board (CAB)

#### For High-Risk Changes
```
1. Submit change request 3-5 days ahead
2. Include all required information
3. Present in CAB meeting
4. Get approval
5. Schedule deployment
6. Execute change
7. Report back to CAB
```

## Best Practices

### Issue Management

#### Creating Issues
```
✅ DO:
- Use templates
- Add all labels
- Fill all custom fields
- Include context and links
- Add clear acceptance criteria
- Estimate effort

❌ DON'T:
- Create vague issues
- Skip security considerations
- Forget cost estimates
- Leave out dependencies
- Create duplicates
```

#### Writing Descriptions
```
Good Example:
"Set up ECS cluster for production workload with:
- 3 t3.large instances
- Auto-scaling 3-10 instances
- CloudWatch monitoring
- Cost: ~$150/month
- Target: Q1 2025"

Bad Example:
"Need ECS cluster"
```

### Labeling Strategy

#### Required Labels (Minimum)
```
- Type: type:feature, type:bug, etc.
- Priority: priority:high, priority:medium, etc.
- AWS Service: aws:ecs, aws:vpc, etc.
```

#### Optional but Recommended
```
- Environment: env:dev, env:prod
- Size: size:s, size:m, size:l
- Status: status:blocked (when applicable)
```

### Comments and Communication

#### Good Comment Practices
```
✅ DO:
- Update progress regularly
- Tag people when needed
- Include timestamps for events
- Link to related resources
- Document decisions
- Add screenshots/logs

❌ DON'T:
- Use private channels for important info
- Leave blockers undocumented
- Skip updates for days
- Use unclear references
```

#### Comment Templates

##### Progress Update
```markdown
## Progress Update - YYYY-MM-DD

✅ Completed:
- Task 1
- Task 2

🚧 In Progress:
- Task 3 (80% complete)

⏭️ Next:
- Task 4
- Task 5

🚫 Blockers:
- None / [Describe blocker]
```

##### Blocker Notification
```markdown
## 🚫 BLOCKED - YYYY-MM-DD

**Blocker**: [Description]
**Impact**: [How this affects timeline/other work]
**Needs**: [What's needed to unblock]
**Tagged**: @person-who-can-help

**Alternative**: [Any workaround or alternative approach]
```

##### Deployment Notification
```markdown
## 🚀 Deployment - YYYY-MM-DD HH:MM

**Environment**: [Dev/Staging/Prod]
**Resources**: [List of resources deployed]
**Tests**: ✅ All passing / ❌ [Issues]
**Monitoring**: [Link to dashboard]
**Notes**: [Any important notes]
```

### Project Board Hygiene

#### Daily
```
- Update your in-progress items
- Move completed items
- Check for blockers
```

#### Weekly
```
- Triage new issues in Backlog
- Update priorities
- Review blocked items
- Archive done items (optional)
```

#### Monthly
```
- Review velocity and metrics
- Clean up stale items
- Update custom field options
- Review and improve workflows
```

### Integration with Development

#### Branch Naming
```
feature/aws-ecs-cluster-setup
bugfix/aws-iam-policy-fix
infra/aws-vpc-peering
security/aws-sg-hardening
```

#### Commit Messages
```
feat(iam): add cross-account role for prod access

- Created IAM role with AssumeRole policy
- Added required permissions for ECS
- Configured trust relationship

Closes #123
```

#### PR Descriptions
```markdown
## Changes
[Describe what changed]

## Testing
- [ ] Tested in Dev
- [ ] Tested in Staging
- [ ] Security scan passed

## Deployment Notes
[Any special deployment considerations]

## Closes
Closes #123
Related to #456
```

## Workflow Cheat Sheet

### Quick Reference

| Action | Where | How |
|--------|-------|-----|
| Start work | Ready column | Assign to self |
| Report blocker | Any status | Add label `status:blocked` |
| Request review | In Progress | Create PR with "Closes #X" |
| Complete work | In Review | Close issue after merge |
| Escalate issue | Any status | Change priority, tag lead |
| Find sprint work | Views | "Sprint View" or filter by sprint |
| Check team status | Views | "Team View" |
| Plan next sprint | Views | "Planning Table" view |
| Track costs | Views | "Cost Tracking" view |
| Security items | Views | "Security Dashboard" view |

### Common Filters

```
# My current work
assignee:@me status:in-progress

# High priority items
priority:P0-Critical,P1-High status:!done

# This sprint
sprint:"Sprint 5" status:!done

# Blocked items
status:blocked

# Security items
label:type:security status:!done

# Production issues
label:env:prod label:type:bug

# Recent activity
updated:>3-days-ago
```

## Continuous Improvement

### Metrics to Track
- Sprint velocity
- Cycle time per item
- Time items spend blocked
- Review turnaround time
- Deployment frequency
- Incident response time

### Regular Reviews
- Daily: Personal work status
- Weekly: Team progress and blockers
- Bi-weekly: Sprint retrospective
- Monthly: Process improvements
- Quarterly: Major workflow review

### Feedback Loop
- Collect team feedback regularly
- Try process improvements
- Measure impact
- Keep what works
- Iterate on what doesn't

---

**Remember**: The workflow should serve the team, not the other way around. Adapt these processes to fit your team's needs!
