FROM rg.fr-par.scw.cloud/paswolf/certs:latest AS certs

FROM postgres:16-alpine
COPY --from=certs /certs /certs
RUN chown -R root:postgres /certs && chmod -R 640 /certs/*

ENTRYPOINT ["docker-entrypoint.sh"] 

CMD [ "-c", "ssl=on" , "-c", "ssl_cert_file=/certs/paswolf.com.cer", "-c", "ssl_key_file=/certs/paswolf.com.key"]
