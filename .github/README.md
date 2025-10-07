# GitHub Actions Configuration

## Required Secrets

Configure these secrets in your GitHub repository:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Add the following **Repository secrets**:

```
AWS_ACCESS_KEY_ID     = your-aws-access-key-id
AWS_SECRET_ACCESS_KEY = your-aws-secret-access-key
```

## Required AWS Resources

Before running workflows, manually create:

1. **S3 Bucket** for Terraform state
2. **EC2 Key Pair** in your target region

## Available Workflows

### 1. Deploy Active Directory (Manual)
- **File**: `deploy-ad.yml`
- **Usage**: Direct plan/apply/destroy actions
- **Parameters**:
  - **AD Module**: infrastructure-ad, ec2-ad, client-ad, managed-ad, connector-ad, simple-ad
  - **Action**: plan/apply/destroy
  - **Terraform bucket**: Your S3 bucket name
  - **AWS region**: Target AWS region

### 2. Deploy AD with Approval (Recommended)
- **File**: `deploy-ad-with-approval.yml`
- **Usage**: Plan → Manual approval → Apply/Destroy
- **Parameters**:
  - **AD Module**: Choose which module to deploy
  - **Terraform bucket**: Your S3 bucket name
  - **AWS region**: Target AWS region
  - **Destroy**: Checkbox for destruction

## Deployment Order

1. **infrastructure-ad** (Base infrastructure - required first)
2. **ec2-ad** OR **managed-ad** OR **connector-ad** OR **simple-ad** (Choose one AD type)
3. **client-ad** (Optional - for testing)

## Usage Examples

### Deploy Base Infrastructure
1. Select **Deploy AD with Approval**
2. Choose **AD Module**: `infrastructure-ad`
3. Run workflow and approve apply

### Deploy EC2 Active Directory
1. Select **Deploy AD with Approval**
2. Choose **AD Module**: `ec2-ad`
3. Run workflow and approve apply

### Deploy Test Clients
1. Select **Deploy AD with Approval**
2. Choose **AD Module**: `client-ad`
3. Run workflow and approve apply

## State Management

- Uses **S3 only** for state storage
- Separate state files per module: `{module}/terraform.tfstate`
- State files encrypted in S3
- No DynamoDB locking (simplified for demo)
