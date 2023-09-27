#!/bin/bash

# This script is expected to run for each datapoint upon initialization.

# Change to the appropriate directory
cd /opt/openstudio/server/

# Set log file
log="/opt/openstudio/server/log/datapoint_initialization_script.log"

echo "-----" >> ${log}
echo "Starting datapoint initialization script"
echo `date +"%Y-%m-%d %H:%M:%S"` >> ${log}

# Get the current datapoint id
datapoint_id=${SCRIPT_DATA_POINT_ID}
echo ">> Datapoint id: ${datapoint_id}" >> ${log}

echo "Finished datapoint initialization script" >> ${log}