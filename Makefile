ince .env   
export $(shell sed 's/=.*//' .env)

ssh:= ssh -F terraform/ssh_config

terraform-init:
	cd terraform && terraform init && cd ..

terraform-plan:
	cd terraform && \
	terraform plan && \
	cd ..

terraform-apply:
	cd terraform && \
	terraform apply && \
	cd ..

terraform-destroy:
	cd terraform && \
	terraform destroy && \
	cd ..

packer-build:
	cd packer && \
	packer build template.json && \
	cd ..

ansible-provisioning: provisioning

ansible-provisioning-verbose: provisioning-verbose

provisioning:
	cd ansible && \
	ansible-playbook -i ../terraform/ansible-provisioning/aws-hosts site.yml && \
	cd ..

provisioning-verbose:
	cd ansible && \
	ansible-playbook -vvvv -i ../terraform/ansible-provisioning/aws-hosts site.yml && \
	cd ..


connect:
	$(ssh) perforce
	
move-ssh-config-to-ssh-directory:
	cd terraform && \
	mv ssh_config ~/.ssh/config && \
	cd ..

	
## printing env vars
## format: 
## make print-<Variable Name>
print-%  : ; @echo $* = $($*)
