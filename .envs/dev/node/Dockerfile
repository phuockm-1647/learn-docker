
FROM node:latest

COPY node/*.sh /scripts/

RUN chmod a+x /scripts/*.sh

EXPOSE 80 443

CMD ["/scripts/command.sh"]