FROM centos:latest

# Get Centos Image
LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20190801"


# Install packages
RUN dnf -y update
RUN dnf install -y epel-release
RUN dnf groupinstall  -y "Development Tools"
RUN dnf install -y java-11-openjdk-devel curl git python3-pip
#RUN pip3 install supervisor supervisor-stdout

# Move aspace resources to container
COPY archivesspace /opt/archivesspace
COPY plugins/nyu_ead_export_plugin /opt/archivesspace/nyu_ead_export_plugin
COPY plugins/nyu_marcxml_export_plugin /opt/archivesspace/nyu_marccml_export_plugin
COPY plugins/digitization_work_order_plugin /opt/archivesspace/digitization_work_order_plugin
COPY plugins/nyu_sso_plugin /opt/archivesspace/
COPY config/config.rb /opt/archivesspace/common/config/config.rb

# Bootstrap aspace
WORKDIR "/opt/archivesspace/"
RUN curl -Oq http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.39/mysql-connector-java-5.1.39.jar
RUN build/run bootstrap

# Start the app
ENTRYPOINT ["/opt/archivesspace/build/run", "backend:devserver"]