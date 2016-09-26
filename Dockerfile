FROM q4p14/supervisor:latest
MAINTAINER a-schneider9@web.de

# Update local repositories and install the latest PostgreSQL database server
RUN apt-get -y update && apt-get -y install python-software-properties \
software-properties-common postgresql

# Copy the supervisor startup configuration to the configuration directory
COPY ./conf/postgresql_sv.conf /etc/supervisor/config.d/postgresql_sv.conf

# Change postgresql config to accept connections from external sources
RUN sed -i "s/^#listen_.*$/listen_addresses = \'*\'/g" /etc/postgresql/9.5/main/postgresql.conf
RUN echo "hostssl    all    all    0.0.0.0/0    md5" >> /etc/postgresql/9.5/main/pg_hba.conf

# Correct the Error: could not open temporary statistics file "/var/run/postgresql/9.5-main.pg_stat_tmp/global.tmp": No such file or directory
RUN mkdir -p /var/run/postgresql/9.5-main.pg_stat_tmp
RUN chown -R postgres:postgres /var/run/postgresql/9.5-main.pg_stat_tmp

# Expose the PostgreSQL server port
EXPOSE 5432

# Start new containers with supervisor running the copied configuration as
# standard behavior
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor.conf"]
