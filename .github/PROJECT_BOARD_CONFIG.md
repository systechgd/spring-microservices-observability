# GitHub Project Board Configuration

This document provides step-by-step instructions for setting up your AWS Organization Development GitHub Project board.

## Table of Contents
1. [Initial Project Setup](#initial-project-setup)
2. [Column Configuration](#column-configuration)
3. [Custom Fields Setup](#custom-fields-setup)
4. [Automation Rules](#automation-rules)
5. [Views Configuration](#views-configuration)
6. [Filters and Queries](#filters-and-queries)

## Initial Project Setup

### Step 1: Create the Project

1. Navigate to your repository on GitHub
2. Click on the **"Projects"** tab
3. Click **"New Project"** button
4. Choose **"Board"** layout (you can add more views later)
5. Name your project: `AWS Organization Development - Q1 2025` (adjust quarter/year as needed)
6. Click **"Create"**

### Step 2: Project Settings

1. Click the **⚙️ Settings** icon in your project
2. Update the project description:
   ```
   AWS Organization infrastructure development and management tracking.
   Includes IAM, VPC, ECS, monitoring, and security implementations.
   ```
3. Set visibility (Private or Public)
4. Configure access control (who can view/edit)

## Column Configuration

### Default Columns Setup

Configure the following columns in your Board view:

#### 1. 📋 Backlog
- **Purpose**: Items that need to be prioritized and planned
- **Criteria**: Not yet ready to start
- **Automation**: Auto-add new issues with label `needs-triage`

#### 2. 🎯 Ready
- **Purpose**: Prioritized items ready to be picked up
- **Criteria**: All requirements clear, no blockers
- **Automation**: Move here when labels removed: `needs-triage`, `status:blocked`

#### 3. 🚧 In Progress
- **Purpose**: Active development work
- **Criteria**: Someone is actively working on this
- **Automation**: Move here when issue is assigned

#### 4. 👀 In Review
- **Purpose**: Code review, testing, or approval pending
- **Criteria**: Implementation complete, awaiting verification
- **Automation**: Move here when PR is created and linked

#### 5. ✅ Done
- **Purpose**: Completed work
- **Criteria**: Deployed and verified
- **Automation**: Move here when issue is closed

#### 6. 🔒 Blocked
- **Purpose**: Items that cannot progress
- **Criteria**: Has dependencies or blockers
- **Automation**: Move here when label `status:blocked` is added

### Creating Columns

1. In your project board, click **"+ New column"**
2. Enter the column name (copy from above)
3. Repeat for all columns
4. Drag to reorder columns in the sequence above

## Custom Fields Setup

Custom fields help you track additional metadata beyond labels.

### Step 1: Add Custom Fields

Click **"+ New field"** in your project and create these fields:

#### 1. Priority (Single Select)
- **Type**: Single select
- **Options**:
  - 🔴 P0 - Critical (Color: Red)
  - 🟠 P1 - High (Color: Orange)
  - 🟡 P2 - Medium (Color: Yellow)
  - 🟢 P3 - Low (Color: Green)

#### 2. AWS Service (Single Select)
- **Type**: Single select
- **Options**: IAM, VPC, EC2, ECS, Lambda, S3, RDS, CloudWatch, Route53, ALB/NLB, CloudFront, Security Hub, GuardDuty, Other

#### 3. Environment (Single Select)
- **Type**: Single select
- **Options**: Dev, Staging, Production, All

#### 4. Effort (Number)
- **Type**: Number
- **Description**: Story points (1, 2, 3, 5, 8, 13)

#### 5. Sprint (Text)
- **Type**: Text
- **Description**: Sprint identifier (e.g., "Sprint 1", "2025-W01")

#### 6. AWS Account (Text)
- **Type**: Text
- **Description**: AWS Account ID or name

#### 7. Owner (Single Select)
- **Type**: Single select
- **Options**: Team member names

#### 8. Target Date (Date)
- **Type**: Date
- **Description**: Target completion date

#### 9. Cost Impact (Number)
- **Type**: Number
- **Description**: Monthly cost impact in USD

#### 10. Status Detail (Text)
- **Type**: Text
- **Description**: Additional status information

### Step 2: Set Field Defaults

1. Click the field name to edit
2. Set default values where appropriate
3. Enable "Show on cards" for important fields

## Automation Rules

Set up automation to reduce manual work.

### Step 1: Access Automations

1. In your project, click **⚙️ Settings**
2. Select **"Workflows"** from the left sidebar

### Step 2: Enable Built-in Workflows

#### Auto-add to project
```
When: Issue opened
Match: Repository = current repo
Then: Add to project
Set: Status = Backlog
```

#### Auto-archive
```
When: Issue closed
Match: Status = Done
Then: Archive item after 30 days
```

#### Auto-assign status
```
When: Issue assigned
Match: Status = Backlog OR Status = Ready
Then: Set status = In Progress
```

#### Pull request linked
```
When: Pull request opened
Match: Issue linked
Then: Set status = In Review
```

#### Issue closed
```
When: Issue closed
Match: Any issue
Then: Set status = Done
```

#### Blocked label
```
When: Label added
Match: Label = status:blocked
Then: Set status = Blocked
```

### Step 3: Custom Workflows (Optional)

Create custom workflows for specific needs:

#### High Priority Alert
```
When: Custom field changed
Match: Priority = P0 - Critical
Then: Add comment mentioning @team
```

#### Production Changes
```
When: Label added
Match: Label = env:prod
Then: Add comment "⚠️ Production change - ensure approval"
```

## Views Configuration

Create multiple views to see your project from different angles.

### View 1: Board (Default)
- **Type**: Board
- **Group by**: Status
- **Sort by**: Priority (descending)
- **Filter**: Status != Done (hide completed)

### View 2: Planning Table
- **Type**: Table
- **Columns**: Title, Status, Priority, AWS Service, Effort, Sprint, Owner
- **Sort by**: Priority (descending), then Effort (ascending)
- **Filter**: Status = Backlog OR Status = Ready

### View 3: Sprint View
- **Type**: Board
- **Group by**: Sprint
- **Filter**: Status != Done
- **Sort by**: Priority

### View 4: By AWS Service
- **Type**: Board
- **Group by**: AWS Service
- **Filter**: Status != Done
- **Sort by**: Priority

### View 5: Team View
- **Type**: Board
- **Group by**: Owner
- **Filter**: Status = In Progress OR Status = In Review

### View 6: Security Dashboard
- **Type**: Table
- **Columns**: Title, Status, Priority, Environment, Target Date
- **Filter**: Label = type:security
- **Sort by**: Priority, Target Date

### View 7: Cost Tracking
- **Type**: Table
- **Columns**: Title, AWS Service, Environment, Cost Impact, Status
- **Filter**: Cost Impact > 0
- **Sort by**: Cost Impact (descending)

### View 8: Roadmap
- **Type**: Roadmap (if available)
- **Date field**: Target Date
- **Group by**: AWS Service

### Creating Views

1. Click **"+ New view"** in your project
2. Choose view type (Board, Table, or Roadmap)
3. Configure grouping, sorting, and filters
4. Save and name the view

## Filters and Queries

### Useful Filter Examples

#### Current Sprint Work
```
status:in-progress OR status:in-review
sprint:"Sprint 5"
```

#### High Priority Items
```
priority:P0-Critical OR priority:P1-High
status:!done
```

#### Security Items Due Soon
```
label:type:security
target-date:<2025-02-01
```

#### Blocked Items Needing Attention
```
status:blocked
updated:<7-days-ago
```

#### Production Changes This Month
```
label:env:prod
created:>2025-01-01
```

#### By Cost Impact
```
cost-impact:>1000
status:!done
```

### Saved Filters

Create saved filters for common queries:

1. Click the **filter** icon in your view
2. Build your filter using the UI
3. Click **"Save as"** to name your filter
4. Access from the filter dropdown later

## Project Insights (Analytics)

### Enable Insights

1. Go to project settings
2. Enable **"Insights"** tab
3. Configure charts:

#### Velocity Chart
- **Type**: Line chart
- **X-axis**: Date (weeks)
- **Y-axis**: Sum of Effort
- **Filter**: Status = Done

#### Burndown Chart
- **Type**: Line chart
- **X-axis**: Date
- **Y-axis**: Count of issues
- **Filter**: Sprint = [Current]

#### Issue Distribution
- **Type**: Pie chart
- **Group by**: Priority
- **Filter**: Status != Done

#### Service Distribution
- **Type**: Bar chart
- **Group by**: AWS Service
- **Y-axis**: Count

#### Cycle Time
- **Type**: Line chart
- **Measure**: Time in "In Progress"
- **Average by**: Week

## Project Milestones Integration

### Link Milestones to Project

1. Create milestones in your repository:
   - **Milestone 1**: AWS Organization Setup
   - **Milestone 2**: Network Foundation
   - **Milestone 3**: Security Baseline
   - **Milestone 4**: Compute Platform
   - **Milestone 5**: Monitoring & Observability
   - **Milestone 6**: Production Ready

2. Assign issues to milestones
3. Track milestone progress in your project views

### Milestone Filter
```
milestone:"Security Baseline"
status:!done
```

## Team Collaboration

### Daily Standup View
Create a view for daily standups:
- **Filter**: `status:in-progress OR status:blocked`
- **Group by**: Owner
- **Sort by**: Priority

### Sprint Planning View
- **Filter**: `status:backlog OR status:ready`
- **Sort by**: Priority, Effort
- **Table view** with all custom fields visible

### Retrospective View
- **Filter**: `closed:>7-days-ago`
- **Group by**: AWS Service
- **Show**: Title, Status, Completion Date, Owner

## Keyboard Shortcuts

Speed up your workflow with these shortcuts:

- **`e`**: Edit selected item
- **`x`**: Select item
- **`Cmd/Ctrl + Enter`**: Save and close
- **`Cmd/Ctrl + k`**: Open command palette
- **`/`**: Focus filter
- **`c`**: Create new item

## Mobile Access

Access your project on mobile:
1. Install GitHub mobile app
2. Navigate to your repository
3. Tap **Projects** tab
4. Full project functionality available

## Export and Reporting

### Export to CSV
1. Open Table view
2. Click **"..."** menu
3. Select **"Export to CSV"**
4. Use for external reporting

### API Access
Use GitHub GraphQL API for custom reporting:
```graphql
query {
  repository(owner: "your-org", name: "your-repo") {
    projectV2(number: 1) {
      items(first: 100) {
        nodes {
          content {
            ... on Issue {
              title
              state
            }
          }
          fieldValues(first: 10) {
            nodes {
              ... on ProjectV2ItemFieldValueCommon {
                field {
                  ... on ProjectV2FieldCommon {
                    name
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

## Maintenance

### Weekly Maintenance Tasks
- [ ] Review and triage items in Backlog
- [ ] Update blocked items
- [ ] Archive completed items
- [ ] Update sprint field for new sprint
- [ ] Review and update priorities

### Monthly Maintenance Tasks
- [ ] Review velocity and cycle time
- [ ] Archive old Done items
- [ ] Update team members in Owner field
- [ ] Review and update AWS Service options
- [ ] Clean up stale items

## Tips and Best Practices

1. **Keep it Simple**: Start with basic setup, add complexity as needed
2. **Consistent Updates**: Update item status in real-time
3. **Clear Descriptions**: Write clear titles and descriptions
4. **Link Everything**: Link PRs, issues, and documentation
5. **Regular Grooming**: Review backlog weekly
6. **Use Templates**: Always use issue templates
7. **Tag Appropriately**: Use labels and custom fields consistently
8. **Review Metrics**: Check insights weekly to improve process
9. **Team Buy-in**: Ensure whole team uses the project
10. **Iterate**: Continuously improve your workflow

## Troubleshooting

### Items Not Auto-adding
- Check automation rules are enabled
- Verify label matches automation criteria
- Check repository permissions

### Custom Fields Not Showing
- Enable "Show on cards" in field settings
- Check view configuration
- Refresh the page

### Automation Not Working
- Verify webhook is active
- Check automation logs in settings
- Ensure no conflicting rules

## Additional Resources

- [GitHub Projects Documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [GraphQL API for Projects](https://docs.github.com/en/graphql/reference/objects#projectv2)
- [GitHub CLI for Projects](https://cli.github.com/manual/gh_project)

---

**Next Steps**: After setting up your project, refer to `PROJECT_TEMPLATE.md` for usage guidelines and workflow best practices.
