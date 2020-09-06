Host *
	SendEnv LANG LC_*
  StrictHostKeyChecking no
  User ubuntu
  IdentityFile ${ ssh_key }

Host perforce
  HostName ${ bastion_node }
  ControlMaster auto
  ControlPath ~/.ssh/ansible-%r@%h:%p
  ControlPersist 5m
  ForwardAgent yes
  ForwardX11 yes