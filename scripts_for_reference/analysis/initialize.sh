#!/bin/bash

# This script is expected to run on the web pod when the analysis starts.

# Change to the appropriate directory
cd /opt/openstudio/server/

# Set log file
log="/opt/openstudio/server/log/analysis_initialization_script.log"

echo "-----" >> ${log}
echo "Starting analysis initialization script"
echo `date +"%Y-%m-%d %H:%M:%S"` >> ${log}

# Get the current analysis id
analysis_id=${ANALYSIS_ID}
echo ">> Analysis id: ${analysis_id}" >> ${log}

echo "Finished analysis initialization script" >> ${log}