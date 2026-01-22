GitHub Actions EC2 SSM Deployment

This repository demonstrates how to set up a CI/CD pipeline using GitHub Actions to deploy code directly to an AWS EC2 instance via AWS Systems Manager (SSM).
No need to expose SSH (port 22), making deployments secure and scalable.


Create a Role and attach this Policy "AmazonSSMManagedInstanceCore" and then attach the IAM Role to ec2

systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent 
systemctl status snap.amazon-ssm-agent.amazon-ssm-agent #Now you don't see any errors

IAM -> Identity Providers -> Add provider -> OpenID Connect
provider URL : token.actions.githubusercontent.com
Audiance : sts.amazonaws.com
Github Username like yasirziaaulakh

IAM -> Role 
Role name like "Github-pipeline-to-ec2"
When we Create the Role then we use the Above Identity-Provider and then Allow access to 
ec2,s3,AmazonSSMManagedInstanceCore

Now copy the above Role ARN and then use in the github action main.yaml file.

 name: Configure AWS credentials using OIDC
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::533452345234545:role/Github-pipeline-to-ec2
          aws-region: us-east-1   # change if needed

 - name: Run deployment script via SSM
        run: |
          COMMAND_ID=$(aws ssm send-command \
            --targets "Key=instanceIds,Values=${{ secrets.PRODUCTION_EC2_INSTANCE_ID }}" \
            --document-name "AWS-RunShellScript" \
            --comment "Deploy CrmFastHoliday Backend" \
            --parameters '{"commands":["/home/ubuntu/DeploymentScripts/myapp-main/mainBackend.sh"]}' \
            --query "Command.CommandId" \
            --output text)



------------------------------
Install this one also on ec2
-------------------------------

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install -y unzip
unzip awscliv2.zip

sudo ./aws/install

aws --version

------------------------------------------------------------------------------------
Below command will not run directly on ec2 but through this you can debug the issue
------------------------------------------------------------------------------------
aws ssm send-command \
  --instance-ids i-0b773e920ec942ec8 \
  --document-name "AWS-RunShellScript" \
  --parameters commands="echo SSM_WORKING" \
  --region ap-south-1









