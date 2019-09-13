FROM centos:latest

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20190801"

RUN yum install -y epel-release

RUN yum install -y java-1.8.0-openjdk curl git python-pip

RUN pip install supervisor supervisor-stdout

COPY archivesspace /opt/archivesspace
COPY plugins/nyu_ead_export_plugin /opt/archarchivesspace/nyu_ead_export_plugin
COPY plugins/nyu_marcxml_export_plugin /opt/archarchivesspace/nyu_marccml_export_plugin
COPY plugins/digitization_work_order_plugin /opt/archarchivesspace/digitization_work_order_plugin
COPY plugins/nyu_sso_plugin /opt/archarchivesspace/
COPY config/config.rb /opt/archivesspace/common/config/config.rb

WORKDIR "/opt/archivesspace/"

RUN curl -Oq http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.39/mysql-connector-java-5.1.39.jar

RUN build/run bootstrap

RUN build/run db:migrate

ENTRYPOINT ["supervisord", "-c", "supervisord/api.conf"]