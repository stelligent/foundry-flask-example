## Steps to the DevOps

    export AWS_PROFILE=

## Deploying Stuff

    cd devops
    packer build packer.pkr.hcl


    aws cloudformation deploy \
    --stack-name GenAIDataStores \
    --template-file dataStores.yaml \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
