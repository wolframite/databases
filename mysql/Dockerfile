FROM registry.paswolf.com/certs AS certs

FROM mysql:8.0
COPY --from=certs /certs /certs
RUN chown -R mysql:mysql /certs && chmod -R 640 /certs/*

ENTRYPOINT ["docker-entrypoint.sh"] 
