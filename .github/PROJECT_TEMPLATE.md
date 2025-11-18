# GitHub Project Template for AWS Organization Development

This template provides a structured approach to managing AWS organization development using GitHub Projects.

## Quick Start

### 1. Create a New GitHub Project

1. Go to your repository → **Projects** tab
2. Click **"New Project"**
3. Choose **"Board"** or **"Table"** view
4. Name it: `AWS Organization Development - [Quarter/Year]`

### 2. Set Up Project Views

#### Board View - Kanban Style
Create columns with these statuses:
- 📋 **Backlog** - Items to be prioritized
- 🎯 **Ready** - Prioritized and ready to start
- 🚧 **In Progress** - Active development
- 👀 **In Review** - Code review/testing
- ✅ **Done** - Completed items
- 🔒 **Blocked** - Items with dependencies/issues

#### Table View - Detailed Tracking
Add these custom fields:
- **Priority**: Dropdown (P0-Critical, P1-High, P2-Medium, P3-Low)
- **Component**: Dropdown (IAM, VPC, EC2, S3, Lambda, ECS, Monitoring, Security, etc.)
- **Effort**: Number (Story points 1-13)
- **Sprint**: Text (Sprint number or date range)
- **AWS Account**: Dropdown (Dev, Staging, Prod, Management)
- **Owner**: Single select (Team member)
- **Dependencies**: Text (Link to blocking issues)

### 3. Configure Automation

Enable these workflow automations:
1. **Auto-add to project**: When issues/PRs are created with specific labels
2. **Status changes**:
   - Move to "In Progress" when issue is assigned
   - Move to "In Review" when PR is created
   - Move to "Done" when issue is closed
3. **Notifications**: Set up alerts for blocked items

## Project Structure

```
AWS Organization Development Project
│
├── Backlog (Column)
│   ├── AWS Account Setup
│   ├── IAM Configuration
│   └── Network Architecture
│
├── Ready (Column)
│   ├── VPC Configuration
│   └── Security Groups
│
├── In Progress (Column)
│   ├── ECS Cluster Setup
│   └── Load Balancer Config
│
├── In Review (Column)
│   └── CloudWatch Integration
│
├── Done (Column)
│   └── S3 Bucket Policies
│
└── Blocked (Column)
    └── Cross-Account Access (waiting on approval)
```

## Issue Labels System

Use the labels defined in `.github/labels.yml`:

### By Type
- `type:feature` - New functionality
- `type:bug` - Bug fixes
- `type:infrastructure` - Infrastructure changes
- `type:security` - Security-related work

### By AWS Service
- `aws:iam` - IAM policies/roles
- `aws:vpc` - VPC and networking
- `aws:ec2` - EC2 instances
- `aws:ecs` - ECS/Fargate
- `aws:lambda` - Lambda functions
- `aws:s3` - S3 storage
- `aws:rds` - RDS databases
- `aws:cloudwatch` - Monitoring

### By Priority
- `priority:critical` - P0 - Production down
- `priority:high` - P1 - Important features
- `priority:medium` - P2 - Standard work
- `priority:low` - P3 - Nice to have

### By Environment
- `env:dev` - Development environment
- `env:staging` - Staging environment
- `env:prod` - Production environment

## Issue Templates

Use the provided issue templates in `.github/ISSUE_TEMPLATE/`:
1. `aws-feature.md` - For new AWS features/services
2. `aws-infrastructure.md` - For infrastructure changes
3. `aws-security.md` - For security-related items
4. `bug-report.md` - For bug reports

## Workflow Best Practices

### Daily Workflow
1. **Morning**: Review "In Progress" items, update status
2. **Throughout day**: Move items between columns as they progress
3. **End of day**: Update comments with blockers or progress notes

### Sprint Planning (Bi-weekly)
1. Review completed items from last sprint
2. Groom backlog - add details, estimates, priorities
3. Move prioritized items to "Ready" column
4. Team members pull from "Ready" based on capacity

### Weekly Sync
1. Review "Blocked" items - resolve dependencies
2. Check "In Review" items - ensure timely reviews
3. Verify "In Progress" items are moving forward
4. Prioritize upcoming work in "Ready"

## Integration with Development

### Linking PRs to Issues
Always link PRs to issues:
```markdown
Closes #123
Related to #456
```

### Commit Messages
Reference issues in commits:
```bash
git commit -m "feat(iam): add cross-account role - closes #123"
git commit -m "fix(vpc): correct subnet CIDR - fixes #456"
```

### Branch Naming
Follow this pattern:
```
feature/aws-[service]-[short-description]
bugfix/aws-[service]-[short-description]
infra/aws-[service]-[short-description]
```

Examples:
- `feature/aws-ecs-cluster-setup`
- `bugfix/aws-iam-policy-permissions`
- `infra/aws-vpc-peering-config`

## Project Milestones

Create milestones for major deliverables:
1. **AWS Organization Setup** - Initial account structure
2. **Network Foundation** - VPC, subnets, routing
3. **Security Baseline** - IAM, security groups, policies
4. **Compute Platform** - ECS/EC2 setup
5. **Monitoring & Logging** - CloudWatch, X-Ray integration
6. **Production Ready** - All services deployed and tested

## Metrics to Track

Monitor these metrics in your project:
- **Velocity**: Story points completed per sprint
- **Cycle Time**: Time from "Ready" to "Done"
- **Blocked Time**: How long items stay blocked
- **Review Time**: Time spent in "In Review"
- **Bug Rate**: Bugs vs features ratio

## Example Project Setup Commands

### Using GitHub CLI (if available)
```bash
# Create project
gh project create "AWS Organization Development Q1 2025" --owner @me

# Add custom fields (via web UI - no CLI support yet)
# Add automation rules (via web UI)
```

### Manual Setup via Web UI
1. Navigate to repository → Projects → New Project
2. Select template or start blank
3. Configure columns and fields as described above
4. Enable automation in project settings
5. Add issues to project using project sidebar

## Templates for Common AWS Tasks

### Task: Create New AWS Service
1. Create issue from `aws-feature.md` template
2. Add labels: `type:feature`, `aws:[service]`, `priority:[level]`
3. Add to project in "Backlog" column
4. Fill in custom fields (Priority, Component, Effort, AWS Account)
5. Assign to team member when ready
6. Link to any related issues or documentation

### Task: Security Update
1. Create issue from `aws-security.md` template
2. Add labels: `type:security`, relevant AWS service label
3. Set high priority
4. Add to "Ready" column for immediate attention
5. Track through to completion
6. Document resolution in issue comments

### Task: Infrastructure Change
1. Create issue from `aws-infrastructure.md` template
2. Add labels: `type:infrastructure`, relevant service labels
3. Document dependencies and impact
4. Add to "Backlog" for planning
5. Move to "Ready" after architecture review
6. Ensure peer review before deployment

## Additional Resources

- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [AWS Organizations Best Practices](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_best-practices.html)

## Support

For questions or issues with this template:
1. Check existing issues in the repository
2. Create a new issue with label `type:documentation`
3. Tag the project maintainer
