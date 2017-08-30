#!/usr/bin/env bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
SCRIPT_NAME=$(basename $0)

# Apply defaults for environment variables required by cql scripts.
# This ensures backwards compatibility with old service definitions.
export DATACENTER=${DATACENTER:-datacenter1}
export REPLICATION=${REPLICATION:-1}


log () {
    echo $(date "+%y/%m/%d %H:%M:%S") "$1 $SCRIPT_NAME: $2"
}


# Run all cql files from the schema directory
init_schema() {
    while ! nc -vz localhost 9042 &>/dev/null ; do
        log INFO "Cassandra not ready; waiting..."
        sleep 3;
    done

    for cql_file in $(find $SCRIPT_DIR/schema -name "*.cql") ; do
        if ! output=$(cqlsh -e "$(envsubst <$cql_file)" 2>&1) ; then
            log ERROR "Failed loading \"$cql_file\":\n$output"
        else
            log INFO "Loaded \"$cql_file\""
        fi
    done
}

# Give Cassandra a little time to come up, then initialize the schema.
(sleep 10; init_schema)&

# Start cassandra
exec $SCRIPT_DIR/docker-entrypoint.sh $@
