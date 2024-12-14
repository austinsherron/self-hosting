# self-hosting

This repo contains code related to my self-hosted applications.

## Manual Setup

### 1-Time Setup

- [ ] Setup NAS w/ NFS shares; shares include:
  - [ ] austin - /nfs/austin
  - [ ] apps - /nfs/apps
  - [ ] backups - /nfs/backups
- [ ] Setup server(s)
  - [ ] Install ubuntu
  - [ ] Connect to internet

## Workflows

## Todo

- [ ] Update server-0 ssh config to require password and key
- [ ] Fix terraform bootstrap playbook
- [ ] Update ansible workflow so I don't have to enter a "sudo password" for every playbook
- [ ] Backfill terraform for tailscale acl and k8s-operator oauth client
- [ ] Add mechanism for passing secrets to terraform/ansible
