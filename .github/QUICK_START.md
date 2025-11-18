# Quick Start Guide - GitHub Project for AWS Development

Get your AWS Organization Development project up and running in 30 minutes!

## Prerequisites

- GitHub repository access with admin permissions
- GitHub CLI installed (optional, but recommended)
- AWS Organization or accounts to manage

## 5-Minute Setup (Minimal)

### Step 1: Create the Project (2 minutes)
1. Go to your repository on GitHub
2. Click **"Projects"** tab → **"New Project"**
3. Choose **"Board"** template
4. Name it: `AWS Organization Development - Q1 2025`
5. Click **"Create"**

### Step 2: Set Up Columns (2 minutes)
Create these columns in order:
1. 📋 Backlog
2. 🎯 Ready
3. 🚧 In Progress
4. 👀 In Review
5. ✅ Done
6. 🔒 Blocked

Click **"+ Add column"** for each.

### Step 3: Create First Issue (1 minute)
1. Go to **Issues** → **"New Issue"**
2. Choose **"AWS Feature Request"** template
3. Fill in the basics
4. Add to your project
5. Start working!

**🎉 You're ready to start!**

---

## 15-Minute Setup (Recommended)

Everything from 5-minute setup, plus:

### Step 4: Apply Labels (5 minutes)

#### Option A: Using GitHub CLI (Fastest)
```bash
cd your-repo
gh label create "type:feature" -d "New feature" -c "0E8A16"
gh label create "type:bug" -d "Bug fix" -c "D73A4A"
gh label create "type:infrastructure" -d "Infrastructure" -c "5319E7"
gh label create "type:security" -d "Security" -c "B60205"
gh label create "priority:critical" -d "P0 Critical" -c "B60205"
gh label create "priority:high" -d "P1 High" -c "D93F0B"
gh label create "aws:iam" -d "AWS IAM" -c "FF9900"
gh label create "aws:vpc" -d "AWS VPC" -c "FF9900"
gh label create "aws:ecs" -d "AWS ECS" -c "FF9900"
gh label create "env:dev" -d "Development" -c "1D76DB"
gh label create "env:prod" -d "Production" -c "B60205"
```

Or run the provided script:
```bash
bash .github/scripts/apply-labels.sh
```

#### Option B: Manual (Via UI)
1. Go to **Issues** → **Labels**
2. Create labels from `.github/labels.yml`
3. Start with these essential ones:
   - `type:feature`, `type:bug`, `type:infrastructure`
   - `priority:critical`, `priority:high`, `priority:medium`
   - `aws:iam`, `aws:vpc`, `aws:ecs`, `aws:s3`
   - `env:dev`, `env:staging`, `env:prod`

### Step 5: Add Custom Fields (5 minutes)
In your project:
1. Click **"+ New field"**
2. Add these fields:

| Field | Type | Options |
|-------|------|---------|
| Priority | Single select | P0, P1, P2, P3 |
| AWS Service | Single select | IAM, VPC, ECS, Lambda, S3, etc. |
| Environment | Single select | Dev, Staging, Production |
| Effort | Number | Story points |

### Step 6: Enable Basic Automation (3 minutes)
1. Project → **⚙️ Settings** → **Workflows**
2. Enable these workflows:
   - ✅ Auto-add to project
   - ✅ Item closed (move to Done)
   - ✅ Pull request merged (move to Done)

**🚀 You now have a fully functional project!**

---

## 30-Minute Setup (Full Featured)

Everything from 15-minute setup, plus:

### Step 7: Create Additional Views (5 minutes)

#### Sprint View
1. **"+ New view"** → **Board**
2. Name: "Sprint View"
3. Group by: Sprint (after adding Sprint field)
4. Filter: `status:!done`

#### Planning Table
1. **"+ New view"** → **Table**
2. Name: "Planning Table"
3. Add columns: Title, Priority, AWS Service, Effort, Owner
4. Sort by: Priority (desc)

#### Security Dashboard
1. **"+ New view"** → **Table**
2. Name: "Security Dashboard"
3. Filter: `label:type:security`

### Step 8: Import Issue Templates (Already done!)
Templates are in `.github/ISSUE_TEMPLATE/`:
- ✅ `aws-feature.md`
- ✅ `aws-infrastructure.md`
- ✅ `aws-security.md`
- ✅ `bug-report.md`

They're automatically available when creating issues!

### Step 9: Set Up Team (5 minutes)
1. Add "Owner" custom field
2. Add team members as options
3. Assign first few issues
4. Share project link with team

### Step 10: Create First Sprint (5 minutes)
1. Add "Sprint" text field to project
2. Create milestone: "Sprint 1"
3. Add 5-8 issues to backlog
4. Estimate effort for each
5. Set priorities
6. Move to "Ready" column
7. Team members assign themselves

**🎯 You have a production-ready project management system!**

---

## First Day Workflow

### Morning
1. ✅ Check your assigned issues in "In Progress"
2. ✅ Review "Blocked" column
3. ✅ Pick new work from "Ready" column
4. ✅ Assign to yourself (auto-moves to "In Progress")

### During Day
1. ✅ Update issue comments with progress
2. ✅ Create PR when ready (link with "Closes #123")
3. ✅ Request reviews
4. ✅ Review others' PRs

### End of Day
1. ✅ Update all in-progress issues with status
2. ✅ Flag any blockers
3. ✅ Move completed work to "Done"

---

## Quick Tips

### Creating Good Issues
```markdown
❌ Bad: "Set up ECS"
✅ Good: "[AWS] [ECS] Set up production ECS cluster with auto-scaling"

Use templates! They guide you through all necessary details.
```

### Using Labels Effectively
```
Every issue should have at least:
- One type: label (type:feature, type:bug, etc.)
- One priority label (priority:high, priority:medium, etc.)
- One or more AWS service labels (aws:ecs, aws:iam, etc.)
```

### Branch Naming
```
feature/aws-ecs-cluster-setup
bugfix/aws-iam-policy-fix
infra/aws-vpc-peering
security/aws-sg-hardening
```

### Commit Messages
```bash
# Good commit messages
git commit -m "feat(iam): add cross-account role - closes #123"
git commit -m "fix(vpc): correct subnet CIDR - fixes #456"
git commit -m "infra(ecs): update cluster capacity - closes #789"
```

### Linking PRs to Issues
Always include in PR description:
```markdown
Closes #123
Related to #456
```

---

## Common Scenarios

### Scenario 1: Starting New AWS Service
```
1. Create issue from "AWS Feature Request" template
2. Fill in all sections (security, cost, architecture)
3. Add labels: type:feature, aws:[service], priority:[level]
4. Add to project (appears in "Backlog")
5. Team reviews in planning
6. Prioritize and move to "Ready"
7. Developer assigns and starts work
```

### Scenario 2: Production Bug
```
1. Create issue from "Bug Report" template
2. Add labels: type:bug, priority:critical, env:prod
3. Auto-added to project
4. Assign to on-call engineer
5. Fix immediately
6. Deploy and verify
7. Close issue
```

### Scenario 3: Security Vulnerability
```
1. Create issue from "Security Issue" template
2. Set severity (Critical/High/Medium/Low)
3. Add label: type:security, priority:high
4. Immediate containment if critical
5. Develop and test fix
6. Deploy to all environments
7. Document resolution
```

### Scenario 4: Infrastructure Change
```
1. Create issue from "Infrastructure Change" template
2. Fill impact analysis and rollback plan
3. Get approvals (comments from stakeholders)
4. Schedule change window
5. Execute change
6. Verify and monitor
7. Close after 24h monitoring
```

---

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `c` | Create new item |
| `e` | Edit selected item |
| `x` | Select item |
| `/` | Focus filter |
| `Cmd/Ctrl + k` | Command palette |
| `Cmd/Ctrl + Enter` | Save and close |

---

## Troubleshooting

### Issue Not Appearing in Project
- Check automation rules are enabled
- Manually add: Open issue → Projects → Select your project

### Labels Not Available
- Go to Settings → Labels
- Create missing labels from `.github/labels.yml`

### Automation Not Working
- Project Settings → Workflows
- Verify workflows are enabled
- Check repository permissions

### Can't Find Custom Fields
- Open your project
- Click "+ New field" to add
- Enable "Show on cards" in field settings

---

## Next Steps

### After Setup
1. ✅ Read `WORKFLOW_GUIDE.md` for daily workflows
2. ✅ Review `PROJECT_TEMPLATE.md` for detailed usage
3. ✅ Check `PROJECT_BOARD_CONFIG.md` for advanced configuration

### First Sprint
1. Create 10-15 issues for initial work
2. Estimate effort for each
3. Prioritize top items
4. Move to "Ready"
5. Team assigns themselves
6. Start working!

### First Week Goals
- ✅ Everyone has 1-2 assigned issues
- ✅ Team understands workflow
- ✅ All new issues use templates
- ✅ Daily standup using project board
- ✅ Regular status updates

---

## Getting Help

### Documentation
- `PROJECT_TEMPLATE.md` - Overview and usage
- `PROJECT_BOARD_CONFIG.md` - Detailed configuration
- `WORKFLOW_GUIDE.md` - Day-to-day workflows
- `labels.yml` - All available labels

### GitHub Resources
- [GitHub Projects Docs](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [GitHub CLI](https://cli.github.com/)

### Team Support
- Ask in team channel
- Create issue with label `type:documentation`
- Schedule onboarding session

---

## Success Metrics

Track these to measure success:

### Week 1
- ✅ All team members have accounts and access
- ✅ 10+ issues created
- ✅ First sprint planned
- ✅ 3+ issues completed

### Month 1
- ✅ Consistent daily updates
- ✅ 2 sprints completed
- ✅ Team velocity established
- ✅ <2 day average cycle time

### Quarter 1
- ✅ 30+ issues completed
- ✅ Clear velocity trends
- ✅ Process improvements implemented
- ✅ Team satisfaction high

---

**Ready to start? Create your first issue using the templates and begin your AWS development journey!** 🚀
