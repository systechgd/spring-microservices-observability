# GitHub Project Management for AWS Organization Development

Complete project management template for tracking AWS infrastructure and application development using GitHub Projects, Issues, and best practices.

## 📚 Documentation Overview

| Document | Purpose | When to Use |
|----------|---------|-------------|
| **[QUICK_START.md](QUICK_START.md)** | Get started in 5-30 minutes | **Start here!** First time setup |
| **[PROJECT_TEMPLATE.md](PROJECT_TEMPLATE.md)** | Overview and usage guide | Understanding the system |
| **[PROJECT_BOARD_CONFIG.md](PROJECT_BOARD_CONFIG.md)** | Detailed configuration | Setting up advanced features |
| **[WORKFLOW_GUIDE.md](WORKFLOW_GUIDE.md)** | Day-to-day workflows | Daily work and best practices |
| **[labels.yml](labels.yml)** | All label definitions | Applying labels to repository |

## 🚀 Quick Start

### 1. Choose Your Setup Time

- **5 minutes**: Basic board with columns → [Quick Start - 5 min](QUICK_START.md#5-minute-setup-minimal)
- **15 minutes**: + Labels and automation → [Quick Start - 15 min](QUICK_START.md#15-minute-setup-recommended)
- **30 minutes**: Full setup with views → [Quick Start - 30 min](QUICK_START.md#30-minute-setup-full-featured)

### 2. Apply Labels (Optional but Recommended)

```bash
# Using GitHub CLI
cd your-repo
bash .github/scripts/apply-labels.sh
```

Or manually via GitHub UI: Settings → Labels

### 3. Create First Issue

1. Go to Issues → New Issue
2. Choose template: AWS Feature / Infrastructure / Security / Bug
3. Fill in details
4. Add to your project
5. Start working!

## 📁 What's Included

### Issue Templates

Located in `.github/ISSUE_TEMPLATE/`:

- **[aws-feature.md](ISSUE_TEMPLATE/aws-feature.md)** - New AWS services or features
- **[aws-infrastructure.md](ISSUE_TEMPLATE/aws-infrastructure.md)** - Infrastructure changes
- **[aws-security.md](ISSUE_TEMPLATE/aws-security.md)** - Security issues and improvements
- **[bug-report.md](ISSUE_TEMPLATE/bug-report.md)** - Bug reports

### Labels System

**80+ pre-configured labels** organized by:

- **Type**: feature, bug, infrastructure, security, etc.
- **AWS Services**: IAM, VPC, ECS, Lambda, S3, RDS, etc.
- **Priority**: P0-Critical to P3-Low
- **Environment**: Dev, Staging, Production
- **Status**: Blocked, In Progress, Needs Review
- **Size**: XS to XL (effort estimation)
- **Compliance**: SOC2, ISO27001, PCI-DSS, HIPAA, GDPR
- **Cost**: High/Medium/Low impact
- **Specialty**: good-first-issue, tech-debt, performance, etc.

Full list in [labels.yml](labels.yml)

### Project Board Structure

**Columns**:
- 📋 **Backlog** - Items to prioritize
- 🎯 **Ready** - Ready to start
- 🚧 **In Progress** - Active work
- 👀 **In Review** - Code review/testing
- ✅ **Done** - Completed
- 🔒 **Blocked** - Has dependencies

**Custom Fields**:
- Priority (P0-P3)
- AWS Service
- Environment
- Effort (Story points)
- Sprint
- Owner
- Target Date
- Cost Impact

**Views**:
- Board View (Kanban)
- Planning Table
- Sprint View
- By AWS Service
- Team View
- Security Dashboard
- Cost Tracking
- Roadmap

### Scripts

Located in `.github/scripts/`:

- **[apply-labels.sh](scripts/apply-labels.sh)** - Automated label creation

## 🎯 Common Use Cases

### Use Case 1: New AWS Service Implementation

```
1. Create issue from "AWS Feature Request" template
2. Add labels: type:feature, aws:[service], priority:[level]
3. Fill security and cost sections
4. Add to project → Backlog
5. Team reviews and prioritizes
6. Move to Ready → Developer assigns
7. Implement → PR → Review → Deploy → Done
```

**Example**: Setting up ECS cluster
- Issue: "[AWS] [ECS] Production ECS cluster with auto-scaling"
- Labels: `type:feature`, `aws:ecs`, `priority:high`, `env:prod`
- Effort: 8 points
- Cost Impact: $150/month

### Use Case 2: Infrastructure Change

```
1. Create issue from "Infrastructure Change" template
2. Document current and target state
3. Fill impact analysis and rollback plan
4. Get approvals via comments
5. Schedule change window
6. Execute and verify
7. Mark complete after monitoring
```

**Example**: VPC peering setup
- Issue: "[INFRA] [VPC] Peering between Dev and Prod VPCs"
- Labels: `type:infrastructure`, `aws:vpc`, `priority:medium`
- Risk: Medium
- Downtime: None (rolling update)

### Use Case 3: Security Vulnerability

```
1. Create issue from "Security Issue" template
2. Set severity (Critical/High/Medium/Low)
3. Document vulnerability details
4. Immediate containment if critical
5. Develop and test fix
6. Deploy to all environments
7. Verify and document resolution
```

**Example**: IAM policy too permissive
- Issue: "[SECURITY] [IAM] Overly permissive S3 bucket policy"
- Labels: `type:security`, `aws:iam`, `priority:high`
- Severity: High
- Impact: Potential data exposure

### Use Case 4: Production Bug

```
1. Create issue from "Bug Report" template
2. Add labels: type:bug, priority:[level], env:prod
3. Assign to on-call engineer
4. Fix immediately if critical
5. Test thoroughly
6. Deploy and verify
7. Monitor and close
```

**Example**: ECS task failing
- Issue: "[BUG] [ECS] Task continuously restarting in production"
- Labels: `type:bug`, `aws:ecs`, `priority:critical`, `env:prod`
- Severity: Critical
- Impact: Service degradation

## 📊 Project Board Configurations

### For Small Teams (2-5 people)
- Simple Board view
- Basic labels (type, priority, AWS service)
- Weekly planning
- Minimal custom fields

### For Medium Teams (5-15 people)
- Multiple views (Board, Table, Sprint)
- Full label system
- Bi-weekly sprints
- All custom fields
- Automation rules

### For Large Teams (15+ people)
- Multiple projects by domain
- Advanced views and filters
- Scrum/Kanban hybrid
- Detailed metrics tracking
- Integration with external tools

## 🔄 Workflows

### Daily Workflow
```
Morning:
- Check "In Progress" items
- Update status
- Review blockers
- Plan today's work

Throughout Day:
- Update issue comments
- Move items between columns
- Create PRs
- Review code

End of Day:
- Update all active items
- Flag blockers
- Move completed work
```

### Sprint Workflow (Bi-weekly)
```
Sprint Planning:
- Review velocity
- Groom backlog
- Estimate work
- Assign Sprint field
- Commit to work

Daily Standup:
- Review "Team View"
- Discuss blockers
- Adjust priorities

Sprint Review:
- Demo completed work
- Gather feedback
- Create follow-ups

Sprint Retrospective:
- What went well
- What needs improvement
- Action items
```

Full details in [WORKFLOW_GUIDE.md](WORKFLOW_GUIDE.md)

## 🏷️ Labeling Best Practices

### Minimum Required Labels
Every issue should have:
1. **One type label**: `type:feature`, `type:bug`, etc.
2. **One priority label**: `priority:critical` to `priority:low`
3. **One or more AWS service labels**: `aws:ecs`, `aws:iam`, etc.

### Optional but Recommended
- **Environment**: `env:dev`, `env:staging`, `env:prod`
- **Size**: `size:s`, `size:m`, `size:l`
- **Status**: `status:blocked` (when applicable)

### Examples

#### Good Labeling
```
Issue: "Set up production ECS cluster with auto-scaling"
Labels:
- type:feature
- aws:ecs
- priority:high
- env:prod
- size:l
- cost:medium
```

#### Minimal Labeling
```
Issue: "Fix IAM policy permissions"
Labels:
- type:bug
- aws:iam
- priority:high
```

## 🔧 Configuration

### Enable Automation

In Project Settings → Workflows:

1. ✅ **Auto-add to project** - New issues automatically added
2. ✅ **Auto-assign status** - Status updates based on events
3. ✅ **Auto-archive** - Archive closed items after 30 days

### Custom Automations

Create rules for:
- High-priority alerts
- Production change warnings
- Security issue escalation
- Blocked item notifications

## 📈 Metrics and Reporting

### Track These Metrics

**Velocity**: Story points completed per sprint
**Cycle Time**: Time from Ready to Done
**Blocked Time**: How long items stay blocked
**Review Time**: Time spent in review
**Bug Rate**: Bugs vs features ratio
**Cost Tracking**: Monthly AWS cost impact

### Generate Reports

Use GitHub's built-in Insights or export to CSV for:
- Sprint reports
- Velocity charts
- Burndown charts
- Team performance
- Service distribution

## 🤝 Team Onboarding

### For New Team Members

1. Read [QUICK_START.md](QUICK_START.md)
2. Review [WORKFLOW_GUIDE.md](WORKFLOW_GUIDE.md)
3. Get added to GitHub repository
4. Get added as "Owner" option in project
5. Assign first issue
6. Shadow experienced team member
7. Pair on first few issues

### Onboarding Checklist

- [ ] GitHub access granted
- [ ] Read documentation
- [ ] Added to project
- [ ] Slack/Teams channels joined
- [ ] AWS console access (if needed)
- [ ] First issue assigned
- [ ] Paired with mentor
- [ ] Understands workflow

## 🆘 Troubleshooting

### Common Issues

**Issue not appearing in project**
- Check automation rules are enabled
- Manually add: Issue → Projects → Select project

**Labels not available**
- Run `bash .github/scripts/apply-labels.sh`
- Or manually create via Settings → Labels

**Automation not working**
- Check Project Settings → Workflows
- Verify repository permissions
- Re-enable workflows

**Can't find custom fields**
- Open project → "+ New field"
- Enable "Show on cards"

## 🔗 Integrations

### GitHub CLI

```bash
# List issues in project
gh project item-list 1

# Create issue and add to project
gh issue create --project "AWS Org Development"

# View project
gh project view 1
```

### API Access

Use GitHub GraphQL API for:
- Custom reporting
- External tool integration
- Automated workflows
- Data exports

Example in [PROJECT_BOARD_CONFIG.md](PROJECT_BOARD_CONFIG.md#export-and-reporting)

## 📚 Additional Resources

### GitHub Documentation
- [GitHub Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [GitHub Issues](https://docs.github.com/en/issues)
- [GitHub CLI](https://cli.github.com/)

### AWS Resources
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [AWS Organizations Best Practices](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_best-practices.html)
- [AWS Security Best Practices](https://aws.amazon.com/security/best-practices/)

### Infrastructure as Code
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS CloudFormation](https://aws.amazon.com/cloudformation/)
- [AWS CDK](https://aws.amazon.com/cdk/)

## 📝 Customization

This template is designed to be customized for your team:

### Easy Customizations
- Add/remove labels
- Adjust column names
- Modify custom fields
- Update issue templates
- Change automation rules

### Advanced Customizations
- Multiple projects by domain
- Integration with external tools
- Custom reporting dashboards
- Automated deployments
- Slack/Teams notifications

## 🤔 FAQ

**Q: Do I need all 80+ labels?**
A: No! Start with the essential ones (type, priority, AWS services). Add more as needed.

**Q: Which view should I use daily?**
A: Board view for daily work, Table view for planning, Sprint view for sprints.

**Q: How often should we have sprints?**
A: 1-2 weeks is common. Adjust based on your team's velocity.

**Q: What if we don't use sprints?**
A: Use Kanban mode! Focus on limiting WIP and continuous flow.

**Q: Can we use this for multiple AWS accounts?**
A: Yes! Use the "AWS Account" custom field and "Environment" labels.

**Q: How do we track costs?**
A: Use "Cost Impact" custom field and create a "Cost Tracking" view.

## 🎓 Training Resources

### Getting Started (1 hour)
1. Read QUICK_START.md (15 min)
2. Set up project (30 min)
3. Create first issue (15 min)

### Deep Dive (3 hours)
1. PROJECT_TEMPLATE.md (45 min)
2. PROJECT_BOARD_CONFIG.md (60 min)
3. WORKFLOW_GUIDE.md (45 min)
4. Hands-on practice (30 min)

### Team Workshop (2 hours)
1. Overview presentation (30 min)
2. Setup walkthrough (30 min)
3. Workflow practice (45 min)
4. Q&A (15 min)

## 📞 Support

### Getting Help

1. Check documentation in this directory
2. Search existing issues
3. Create issue with label `type:documentation`
4. Ask in team channel

### Contributing

Improvements welcome! To suggest changes:
1. Create issue describing improvement
2. Discuss with team
3. Update documentation
4. Submit PR

## ✅ Success Checklist

### Week 1
- [ ] Project created and configured
- [ ] Labels applied
- [ ] Team has access
- [ ] 5+ issues created
- [ ] Team understands workflow

### Month 1
- [ ] 2+ sprints completed
- [ ] Team velocity established
- [ ] All work tracked in project
- [ ] Regular standup using board
- [ ] Process feels natural

### Quarter 1
- [ ] 30+ issues completed
- [ ] Clear metrics and trends
- [ ] Process improvements made
- [ ] Team satisfaction high
- [ ] Delivering value consistently

---

## 🚀 Ready to Start?

1. **[Start with QUICK_START.md](QUICK_START.md)** for immediate setup
2. Create your first issue using the templates
3. Begin your AWS development journey!

**Questions?** Create an issue or ask your team lead.

**Good luck building your AWS infrastructure!** ☁️
