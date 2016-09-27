The Image contains an installation of PostgreSQL 9.5 database server running on 0.0.0.0/5432. The PostgreSQL configuration is basically blank.

Process management is handled by supervisor, the ENTRYPOINT just starts supervisor in foreground which then runs the PostgreSQL daemon.
