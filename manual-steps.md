# Manual Steps

Reminder to myself, if starting from a clean OS these should be the only steps to take:

```sh
# Fresh install system
apt install -y sudo python3-pip
echo 'lee ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
```

```sh
# Control/ansible runner node
ssh-copy-id lee@1.2.3.4
```

