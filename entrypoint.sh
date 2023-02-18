#!/bin/sh

terraform --version
v_exit_code=$?
if [ $v_exit_code != 0 ]
then
  echo "Terraform version failed!"
  exit 1
fi

terraform init \
  -backend-config="bucket=${TF_VAR_backend_bucket}"
i_exit_code=$?
if [ $i_exit_code != 0 ]
then

  echo "Terraform init failed!"
  exit 1
fi

terraform plan -detailed-exitcode -lock=false -out=tfplan -input=false
exit_code=$?
echo "EXIT CODE: $exit_code"
if [ $exit_code != 0 ]
then
  if [ $exit_code != 2 ]
  then
    echo "plan failed"
    exit 1
  fi
  terraform apply -lock=false -input=false "tfplan"
  if [ $? != 0 ]
  then
    echo "Terraform Applied failed"
    echo "========================"
    exit 1
  fi
  echo "Terraform apply completed"
fi
