Open the file `inventory.yml` in an editor and create an Ansible inventory by copying and pasting the text below.
This is a list of groups of hosts that we'll manage with Ansible.
Here we have a group called `webservers` that has one host, `localhost`.

```
webservers:
  hosts:
    localhost:
      ansible_connection: local

```{{copy}}

Note: if you restart or switch terminal you must reactivate the mambaforge environment:
`. ~/mambaforge/bin/activate`{{exec}}

Now we can check whether the inventory works by attempting to connect using Ansible
`ansible -i inventory.yml -m ping webservers`{{exec}}

Next we can create a playbook.
An Ansible playbook describes what will be done to a server.

First we need to say which servers this playbook will manage, in this case it will manage the host-group called `webservers`.
Open `playbook.yml` and add this

```
- hosts: webservers
  become: true

  tasks:

```{{copy}}

Now we'll start adding tasks.
The first task is to add the upstream Nginx mainline apt repository and signing key from http://nginx.org/en/linux_packages.html#Ubuntu

```
    - name: Import Nginx repository key
      apt_key:
        id: 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
        url: https://nginx.org/keys/nginx_signing.key
        state: present

    - name: Setup Nginx apt repository
      apt_repository:
        repo: deb http://nginx.org/packages/ubuntu focal nginx
        state: present

```{{copy}}

Followed by installing Nginx.

```
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: true

```{{copy}}

Now we can run the playbook, and we should see that Nginx is installed.

`ansible-playbook -i inventory.yml --diff playbook.yml`{{exec}}

Check the version of Nginx
`nginx -v`{{exec}}

If we run `ansible-playbook` again we'll see that nothing is changed.
Ansible sees that the Nginx apt repository and package are already present, so doesn't change anything.

`ansible-playbook -i inventory.yml --diff playbook.yml`{{exec}}

Nginx is installed, but it's not running as you can see by trying `curl localhost`{{exec}}.
Start Nginx, and ensure it's automatically started at boot-up.

```
    - name: Start Nginx, ensure it automatically starts on boot
      service:
        name: nginx
        enabled: true
        state: started

```{{copy}}

`ansible-playbook -i inventory.yml --diff playbook.yml`{{exec}}

Nginx is now running, you should be able to see the default index page at
{{TRAFFIC_HOST1_80}}
