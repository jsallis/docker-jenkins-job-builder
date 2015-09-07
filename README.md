# docker-jenkins-job-builder

A containerized version of the [Jenkins Job Builder](https://github.com/openstack-infra/jenkins-job-builder) tool

## Example usage

#### Assumptions

* You have a terminal open in the `/example_job` directory of this repo
* You have a jenkins server running at `http://192.168.99.100:8080/`

```
docker run --interactive --tty --rm \
  --volume "$PWD":/opt/jenkins-job \
  --workdir /opt/jenkins-job \
  jsallis/jenkins-job-builder \
  jenkins-jobs --conf jenkins.ini test job.yml
```
