# Reflection - M8 Lab 01

**1. Which cloud provider did you choose, and why?**
AWS. I already used it for my EC2/Docker and Prometheus assignments, so my account and CLI were set up and I could compare clicking through the console with doing it in code.

**2. What resource did you create?**
A private S3 bucket with a random suffix, public access blocked, SSE-S3 encryption, tags, and one small text file managed by Terraform.

**3. What does the provider block do?**
It tells Terraform which platform to manage (AWS), which region, and which credentials profile to use. I also used it to apply default tags to every resource.

**4. What is the purpose of the resource block?**
It declares something that should exist. Terraform compares that to its state and the real cloud, then creates, changes, or deletes to match.

**5. Why review terraform plan before apply?**
The plan shows exactly what will be created, changed, or destroyed before anything happens. It's the last chance to catch a wrong name, region, or an accidental deletion.

**6. What happened when you ran terraform destroy?**
Terraform listed 5 resources and deleted them after I typed yes. The file and bucket settings went first, then the bucket. When I refreshed the S3 console, the bucket was gone. Redeploying created a new bucket with a different random name.

**7. What error or challenge did you encounter, and how did you troubleshoot it?**
I needed AWS credentials but didn’t want to use my root account for billing and security reasons. I created an IAM user with only S3 access, made an access key, and checked it with aws sts get-caller-identity before running Terraform.

**8. One benefit of IaC over manual creation?**
It's repeatable. When I deleted my EC2 instance after an earlier assignment I had to rebuild it by hand. With Terraform, rebuilding is `terraform apply`.
