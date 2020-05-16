# Purpose

This is a repository for all the files necessary to have a Docker Stack which can be used for the local development testing of your web application.
The Docker Stack is made of 2 services:
- [gixy] - a tool for testing your nginx.conf file
- [testssl] - a great tool for testing the SSL implementation of your local or non-local web application


# Instructions

Assuming you have Docker installed and Docker Swarm initialized - do the following.


### Prepare the Docker Image for testssl.sh

Build the testssl image.
```sh
cd build/testssl
./build-image.sh
```

### Prepare the Docker Stack configuration

Place your nginx.conf file here.
```sh
./persistance/gixy/conf/nginx.conf
```
Change the dummy settings in the ./deploy/docker-compose.yml
```yaml
x-default-extra_hosts: &default-extra_hosts
  - "hostname:hostip"
```
```yaml
testssl:
  image: testssl:latest
  command: ["https://hostname"]
```
```yaml
gixy:
  image: yandex/gixy:latest
  volumes:
    - "/opt/docker-stacks/appscan/persistance/gixy/conf/nginx.conf:/etc/nginx/conf/nginx.conf"
```

### Deploy the Stack and View the Scan Results

Make sure your target web application is running, then deploy the stack.
```sh
cd deploy
docker stack deploy appscan -c docker-compose.yml
```
When both images are done with their tasks, the Docker Service will show as stopped. This is intentional due to this setting.
```yaml
'x-default-restart_policy: &default-restart_policy
	condition: none'
```
When the services stop view the logs of each to see the results of your scan. For instance:
```sh
docker logs appscan_gixy.1.1mzk3shd7a3k6twmo9c3r2dnf
docker logs appscan_testssl.1.1mzk3shd7a3k6twmo9c3r2dnf
```

[gixy]: <https://github.com/yandex/gixy>
[testssl]: <https://github.com/drwetter/testssl.sh>