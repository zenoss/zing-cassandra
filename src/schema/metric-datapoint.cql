// Create table for metric datapoints
CREATE KEYSPACE IF NOT EXISTS zendata WITH REPLICATION = { 'class': 'NetworkTopologyStrategy', '$DATACENTER': $REPLICATION };
USE zendata;
CREATE TABLE IF NOT EXISTS metric_with_date (
    id          text,
    metric      text,
    device      text,
    component   text,
    tenant      text,
    date        text,
    timestamp   timestamp,
    value       double,
    PRIMARY KEY ((id,date),timestamp)
);
