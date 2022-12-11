setup:
	terraform apply

destroy:
	terraform destroy

eksctl-setup:
	eksctl create cluster ${AWS_CLUSTER_NAME}

eksctl-teardown:
	eksctl delete cluster ${AWS_CLUSTER_NAME}

connect-eksctl:
	aws eks update-kubeconfig --name ${AWS_CLUSTER_NAME} --region us-east-1
