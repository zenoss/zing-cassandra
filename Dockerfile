FROM cassandra:3.10

RUN apt-get update && \
	apt-get install -y \
		curl lsof \
	&& rm -rf /var/lib/apt/lists/*

RUN chown cassandra /docker-entrypoint.sh
USER cassandra
ENTRYPOINT ["/docker-entrypoint.sh"]
