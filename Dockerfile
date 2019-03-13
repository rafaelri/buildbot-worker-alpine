FROM python:3.7-alpine
RUN mkdir /buildbot && \
      addgroup -S buildbot && adduser -S buildbot -G buildbot && \
      apk add dumb-init gcc musl-dev git && \
      pip install Twisted==18.9.0 && \
      pip install buildbot-worker==2.1.0 
COPY buildbot.tac /buildbot
RUN chown -R buildbot:buildbot /buildbot
USER buildbot
WORKDIR /buildbot
CMD ["/usr/bin/dumb-init", "twistd", "--pidfile=", "-ny", "buildbot.tac"]
