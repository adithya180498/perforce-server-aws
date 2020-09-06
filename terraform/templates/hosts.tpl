[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=${ ansible_ssh_private_key_file }

[perforce]
${ perforce-server  }