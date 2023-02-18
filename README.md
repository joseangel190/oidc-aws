# oidc-aws
To assume AdminRole you also must setup MFA access.

Setup your ~/.aws/config with the following:

```
[andes_admin]
source_profile = andes
role_arn       = arn:aws:iam::849514089141:role/AdminRole
mfa_serial     = <YOUR OWN MFA ARN>
region         = us-west-2
```

aws-profile set
And select:
assume andes_admin
Verify your credentials are working:

aws sts get-caller-identity --no-cli-pager
(This command will request to enter your mfa code)
Then you should see something like this:
```
{
    "UserId": "XXXXXXXXXXXXX:botocore-session-12223333",
    "Account": "849514089141",
    "Arn": "arn:aws:sts::849514089141:assumed-role/AdminRole/botocore-session-1222333"
}
```
We run terraform using docker for consistency.

First make sure you build the docker from the main repo directory:

For example for github_oidc infra:
```
docker build --rm -t github_oidc -f github/Dockerfile .
```
Before running docker run, you must export AWS creds, use the following:
```
eval $(aws-profile export)
```
Now you should be able to run docker using AWS environment variables:
```
docker run  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN -e TF_VAR_backend_bucket=rbn-infra-prod github_oidc
```
