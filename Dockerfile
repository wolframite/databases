FROM postgres:16-alpine

COPY ./certs/ymir.key /var/lib/postgresql
COPY ./certs/ymir.crt /var/lib/postgresql

RUN chown root:postgres /var/lib/postgresql/ymir.key && chmod 640 /var/lib/postgresql/ymir.key
RUN chown root:postgres /var/lib/postgresql/ymir.crt && chmod 640 /var/lib/postgresql/ymir.crt

ENTRYPOINT ["docker-entrypoint.sh"] 

CMD [ "-c", "ssl=on" , "-c", "ssl_cert_file=/var/lib/postgresql/ymir.crt", "-c", "ssl_key_file=/var/lib/postgresql/ymir.key", "-c"]
