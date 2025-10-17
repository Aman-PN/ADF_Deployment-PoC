# Install Databricks Assert Bundles package locally
# pip install databricks-bundles==0.248.0
#
# copy contents into resources/job_15.py
from databricks.bundles.jobs import Job


job_15 = Job.from_dict(
    {
        "name": "job_15",
        "tasks": [
            {
                "task_key": "runt_the_notebook",
                "notebook_task": {
                    "notebook_path": "/Workspace/Users/aman.nandgaule@tcs.com/Notebooks/Notebook1.ipynb",
                    "source": "WORKSPACE",
                },
                "existing_cluster_id": "1006-135509-wb6th5h2",
            },
        ],
        "queue": {
            "enabled": True,
        },
    }
)