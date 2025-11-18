#!/bin/bash

# GitHub Labels Automation Script
# This script creates all labels defined in .github/labels.yml
# Requires: GitHub CLI (gh) installed and authenticated

set -e

echo "🏷️  GitHub Labels Setup Script"
echo "================================"
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "   Install from: https://cli.github.com/"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub CLI."
    echo "   Run: gh auth login"
    exit 1
fi

echo "✅ GitHub CLI is installed and authenticated"
echo ""

# Function to create label
create_label() {
    local name=$1
    local color=$2
    local description=$3

    if gh label create "$name" --color "$color" --description "$description" 2>/dev/null; then
        echo "✅ Created: $name"
    else
        echo "⚠️  Already exists or error: $name"
    fi
}

echo "Creating labels..."
echo ""

# TYPE LABELS
echo "📦 Type Labels"
create_label "type:feature" "0E8A16" "New feature or enhancement"
create_label "type:bug" "D73A4A" "Something isn't working"
create_label "type:infrastructure" "5319E7" "Infrastructure changes (IaC, AWS resources)"
create_label "type:security" "B60205" "Security-related changes or vulnerabilities"
create_label "type:documentation" "0075CA" "Documentation updates or improvements"
create_label "type:refactor" "FBCA04" "Code refactoring without functional changes"
create_label "type:test" "1D76DB" "Testing-related changes"
create_label "type:maintenance" "FEF2C0" "Routine maintenance tasks"
create_label "type:ci-cd" "0052CC" "CI/CD pipeline changes"
create_label "type:monitoring" "C5DEF5" "Monitoring, logging, or observability"
echo ""

# AWS SERVICE LABELS
echo "☁️  AWS Service Labels"
create_label "aws:iam" "FF9900" "AWS IAM (Identity and Access Management)"
create_label "aws:vpc" "FF9900" "AWS VPC and networking"
create_label "aws:ec2" "FF9900" "AWS EC2 instances"
create_label "aws:ecs" "FF9900" "AWS ECS/Fargate"
create_label "aws:lambda" "FF9900" "AWS Lambda functions"
create_label "aws:s3" "FF9900" "AWS S3 storage"
create_label "aws:rds" "FF9900" "AWS RDS databases"
create_label "aws:dynamodb" "FF9900" "AWS DynamoDB"
create_label "aws:cloudwatch" "FF9900" "AWS CloudWatch monitoring"
create_label "aws:cloudfront" "FF9900" "AWS CloudFront CDN"
create_label "aws:route53" "FF9900" "AWS Route53 DNS"
create_label "aws:alb" "FF9900" "AWS Application Load Balancer"
create_label "aws:nlb" "FF9900" "AWS Network Load Balancer"
create_label "aws:elasticache" "FF9900" "AWS ElastiCache (Redis/Memcached)"
create_label "aws:sqs" "FF9900" "AWS SQS queues"
create_label "aws:sns" "FF9900" "AWS SNS notifications"
create_label "aws:kinesis" "FF9900" "AWS Kinesis streams"
create_label "aws:secrets-manager" "FF9900" "AWS Secrets Manager"
create_label "aws:kms" "FF9900" "AWS KMS encryption"
create_label "aws:organizations" "FF9900" "AWS Organizations"
create_label "aws:control-tower" "FF9900" "AWS Control Tower"
create_label "aws:security-hub" "FF9900" "AWS Security Hub"
create_label "aws:guardduty" "FF9900" "AWS GuardDuty"
create_label "aws:config" "FF9900" "AWS Config"
create_label "aws:cloudtrail" "FF9900" "AWS CloudTrail"
create_label "aws:xray" "FF9900" "AWS X-Ray tracing"
echo ""

# PRIORITY LABELS
echo "🎯 Priority Labels"
create_label "priority:critical" "B60205" "P0 - Critical priority, production down"
create_label "priority:high" "D93F0B" "P1 - High priority, important feature"
create_label "priority:medium" "FBCA04" "P2 - Medium priority, standard work"
create_label "priority:low" "FEF2C0" "P3 - Low priority, nice to have"
echo ""

# ENVIRONMENT LABELS
echo "🌍 Environment Labels"
create_label "env:dev" "1D76DB" "Development environment"
create_label "env:staging" "0E8A16" "Staging environment"
create_label "env:prod" "B60205" "Production environment"
create_label "env:all" "5319E7" "All environments"
echo ""

# STATUS LABELS
echo "📊 Status Labels"
create_label "status:blocked" "D73A4A" "Blocked by dependency or external factor"
create_label "status:in-progress" "0E8A16" "Currently being worked on"
create_label "status:needs-review" "FBCA04" "Ready for review"
create_label "status:needs-testing" "FF9900" "Needs testing or QA"
create_label "status:on-hold" "FEF2C0" "On hold, not currently active"
create_label "needs-triage" "E99695" "Needs initial triage and prioritization"
echo ""

# SIZE/EFFORT LABELS
echo "📏 Size/Effort Labels"
create_label "size:xs" "C2E0C6" "Extra small - < 2 hours"
create_label "size:s" "C2E0C6" "Small - 2-4 hours"
create_label "size:m" "BFDADC" "Medium - 1-2 days"
create_label "size:l" "F9D0C4" "Large - 3-5 days"
create_label "size:xl" "F9D0C4" "Extra large - 1+ weeks"
echo ""

# COMPLIANCE LABELS
echo "📋 Compliance Labels"
create_label "compliance:soc2" "5319E7" "SOC 2 compliance related"
create_label "compliance:iso27001" "5319E7" "ISO 27001 compliance related"
create_label "compliance:pci-dss" "5319E7" "PCI DSS compliance related"
create_label "compliance:hipaa" "5319E7" "HIPAA compliance related"
create_label "compliance:gdpr" "5319E7" "GDPR compliance related"
echo ""

# COST LABELS
echo "💰 Cost Labels"
create_label "cost:high" "D93F0B" "High cost impact (> \$1000/month)"
create_label "cost:medium" "FBCA04" "Medium cost impact (\$100-\$1000/month)"
create_label "cost:low" "C5DEF5" "Low cost impact (< \$100/month)"
create_label "cost:optimization" "0E8A16" "Cost optimization opportunity"
echo ""

# IMPACT LABELS
echo "💥 Impact Labels"
create_label "impact:high" "D93F0B" "High business or user impact"
create_label "impact:medium" "FBCA04" "Medium business or user impact"
create_label "impact:low" "C5DEF5" "Low business or user impact"
echo ""

# SPECIALTY LABELS
echo "⭐ Specialty Labels"
create_label "good-first-issue" "7057FF" "Good for newcomers"
create_label "help-wanted" "008672" "Extra attention needed"
create_label "question" "D876E3" "Further information requested"
create_label "duplicate" "CFD3D7" "Duplicate of another issue"
create_label "wontfix" "FFFFFF" "Will not be worked on"
create_label "breaking-change" "B60205" "Breaking change that requires migration"
create_label "tech-debt" "F4C20D" "Technical debt to be addressed"
create_label "dependencies" "0366D6" "Dependencies update or management"
create_label "performance" "FF6B6B" "Performance improvement or issue"
echo ""

echo "================================"
echo "✅ Label setup complete!"
echo ""
echo "View your labels at:"
echo "https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/labels"
echo ""
echo "Next steps:"
echo "1. Create a GitHub Project for your repository"
echo "2. Use issue templates in .github/ISSUE_TEMPLATE/"
echo "3. Follow the QUICK_START.md guide"
