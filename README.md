# docker-oracle-java-8-slim
Dockerfile for Oracle Java 8 on Google's Ubuntu-slim images

This is the dockerfile that defines the image containing oracle java 8 based on google's ubuntu-slim. The uncompressed images size is about 195MB. One can further reduce the image size by removing unecessary part from the java installation. E.g. nashorn. A good example could be found [here](https://github.com/kubernetes/kubernetes/blob/master/examples/storage/cassandra/image/Dockerfile)

The dockerfile is created based on the [one](https://github.com/oracle/docker-images/blob/master/OracleJava/java-8/Dockerfile) in [oracle/docker-images](https://github.com/oracle/docker-images/tree/master/OracleJava) repo.
