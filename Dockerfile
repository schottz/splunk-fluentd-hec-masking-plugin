FROM splunk/fluentd-hec:1.3.2

USER root

RUN gem install fluent-plugin-masking -v 1.3.1

ENV HIDDEN_FIELDS=

COPY ./entrypoint.sh /bin/

RUN chmod +x /bin/entrypoint.sh
