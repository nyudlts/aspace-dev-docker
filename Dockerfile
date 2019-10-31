FROM centos:7

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20190801"

RUN yum update -y
RUN yum install -y epel-release
RUN yum --setopt=group_package_types=mandatory,default,optional group install -y  "Development Tools"
RUN yum install -y java-1.8.0-openjdk curl git python-pip
RUN pip install --upgrade pip
RUN pip install supervisor supervisor-stdout

COPY archivesspace /opt/archivesspace
COPY plugins/nyu_ead_export_plugin /opt/archivesspace/plugins/nyu_ead_export_plugin
COPY plugins/nyu_marcxml_export_plugin /opt/archivesspace/plugins/nyu_marcxml_export_plugin
COPY plugins/digitization_work_order_plugin /opt/archivesspace/plugins/digitization_work_order_plugin
COPY plugins/nyu_sso_plugin /opt/archivesspace/
COPY config/config.rb /opt/archivesspace/common/config/config.rb

WORKDIR "/opt/archivesspace/"

RUN curl -Oq http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.39/mysql-connector-java-5.1.39.jar

RUN build/run bootstrap

ENTRYPOINT ["supervisord", "-c", "supervisord/api.conf"]
