FROM bitnami/git

WORKDIR /path/

RUN git clone https://github.com/PayU/fluent-plugin-masking.git

RUN cd fluent-plugin-masking && \
    git checkout tags/v1.3.1

FROM splunk/fluentd-hec:1.3.2

USER root

COPY --from=0 /path/fluent-plugin-masking /opt/app-root/src/gem/

RUN sed -i 's/fluent-plugin-splunk-hec/fluent-plugin-masking/g' /opt/app-root/src/Gemfile && \
    echo "gem 'fluent-plugin-splunk-hec', path: 'gem/'" >> /opt/app-root/src/Gemfile && \
    chmod 777 /opt/app-root/src/* && \
    chown -R fluent /opt/app-root/src/

ENV HIDDEN_FIELDS=

COPY ./entrypoint.sh /bin/

RUN chmod +x /bin/entrypoint.sh && \
    /bin/entrypoint.sh

USER fluent

RUN bundle install

CMD bundle exec fluentd -c /fluentd/etc/fluent.conf