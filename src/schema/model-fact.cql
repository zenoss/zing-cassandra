// Create table for metric datapoints
CREATE KEYSPACE IF NOT EXISTS zendata WITH REPLICATION = { 'class': 'NetworkTopologyStrategy', '$DATACENTER': $REPLICATION };
USE zendata;
CREATE TABLE IF NOT EXISTS model_fact (
    source      text,
    tenant      text,
    timestamp   timestamp,
    name        text,
    type        text,
    stringvalue text,
    intvalue    bigint,
    doublevalue double,
    boolvalue   boolean,
    PRIMARY KEY ((source,tenant,name),timestamp)
);

CREATE TABLE IF NOT EXISTS model_fact_source (
    id          text,
    tenant      text,
    name        text,
    type        text,
    stringvalue text,
    intvalue    bigint,
    doublevalue double,
    boolvalue   boolean,
    PRIMARY KEY (tenant, id, name)
);
