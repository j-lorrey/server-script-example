@echo off

REM Activate the conda environment
call conda activate server-script-example

REM Run launch_analysis.py to kick off the analysis
call python launch_analysis.py

REM Deactivate the conda environment
call conda deactivate