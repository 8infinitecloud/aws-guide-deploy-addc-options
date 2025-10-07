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

Before running the workflow, create:

1. **S3 Bucket** for Terraform state
2. **DynamoDB Table** named `terraform-state-lock` with partition key `LockID` (String)
3. **EC2 Key Pair** in your target region

## Usage

1. Go to **Actions** tab in GitHub
2. Select **Infrastructure AD Deployment**
3. Click **Run workflow**
4. Fill in the parameters:
   - **Action**: plan/apply/destroy
   - **Terraform bucket**: Your S3 bucket name
   - **AWS region**: Target AWS region

## Workflow Steps

- **Plan**: Review changes without applying
- **Apply**: Deploy infrastructure
- **Destroy**: Remove all resources
