## Background
This repo is for replicating an issue I've been seeing with server scripts on openstudio-server. The specific issue is that analysis initialization scripts are running twice in a row and analysis finalization scripts appear to be running both at analysis initialization and finalization.

## Initial Setup:
1. If you have anaconda/miniconda installed, you can create the environment with `conda env create -f environment.yml`.
2. In config.yml, configure the local path to PAT and the desired server url for openstudio-server.

## Launch the Analysis:
1. Run `run.bat` to activate the conda environment and run the analysis via launch_analysis.py. This is configured to run the included example-job analysis. 

## Server Script Debugging:
1. Unzip example-job.zip to find the configured server scripts. They are also included in the scripts_for_reference directory for convenience.
- The scripts include an analysis initialization script, an analysis finalization script, a datapoint initialization script, and a datapoint finalization script.
- Each script just creates a log file and logs the timestamp of when it starts, as well as the analysis or datapoint id.

2. After running the analysis, check for the log files.
From wherever you manage your openstudio-server kubernetes cluster:
- Run `kubectl get pods` to get the name of the web pod and worker pods
- For the analysis scripts, the log files get created on the web pod in /opt/openstudio/server/log.
    - `kubectl exec -it {web pod} -- /bin/bash`
    - cd /opt/openstudio/server/log
- For the datapoint scripts, the log files get created on one of the worker pods in /opt/openstudio/server/log.
    - `kubectl exec -it {worker pod} -- /bin/bash`
    - cd /opt/openstudio/server/log

## Output
Here's what I found for the analysis initializaiton and finalization script log files:

##### analysis_initialization_script.log:
```
-----
2023-09-27 16:09:57
>> Analysis id: 384e6e1a-6d2d-44de-adc6-402d567aec13
Finished analysis initialization script
-----
2023-09-27 16:09:58
>> Analysis id: 384e6e1a-6d2d-44de-adc6-402d567aec13
Finished analysis initialization script
```
*Runs twice, back to back.*

##### analysis_finalization_script.log:
```
-----
2023-09-27 16:09:58
>> Analysis id: 384e6e1a-6d2d-44de-adc6-402d567aec13
Finished analysis finalization script
-----
2023-09-27 16:11:49
>> Analysis id: 384e6e1a-6d2d-44de-adc6-402d567aec13
Finished analysis finalization script
```
*Runs twice: first time just after initialization script and second time a few minutes later. Appears to line up with analysis initialization and finalization.*

## Notes:
- I haven't messed around with datapoint scripts as much, other than confirming they created the expected logs on the worker pods, so I will exclude those from the debugging.
- Note that 'example-job' is a manual job configured to run with server scripts. In PAT you can only configure algorithmic jobs to have server scripts, so I couldn't test this same job there. I have not done extensive testing in PAT, but I ran these server scripts from PAT and found that they worked as expected (no double runs).