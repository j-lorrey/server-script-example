import yaml
import subprocess


# Helper functions
def load_config() -> dict:
    with open("config.yml", "r") as file:
        config = yaml.safe_load(file)
    return config

config = load_config()

def generate_run_cmd(pat_path: str, server_url: str) -> str:
    base_path = f"{pat_path}/pat"
    openstudio_meta_path = f"{base_path}/OpenStudio-server/bin/openstudio_meta"
    ruby_path = f"{base_path}/ruby/bin/ruby.exe"
    ruby_lib_path = f"{base_path}/OpenStudio/Ruby"

    run_cmd = [
        ruby_path,
        openstudio_meta_path,
        "run_analysis",
        f"--ruby-lib-path={ruby_lib_path}",
        "example-job.json",
        "-zexample-job.zip",
        server_url,
        "--debug",
        "--verbose"
    ]

    return run_cmd

# Execution
config = load_config()
pat_path = config["pat_path"]
server_url = config["server_url"]

if server_url != "":
    run_cmd = generate_run_cmd(pat_path, server_url)

    proc = subprocess.Popen(run_cmd, shell=False)
    print(f"Analysis submitted to {server_url}")

else:
    print("** ERROR ** Please configure a valid server_url in config.yml and try again.")
