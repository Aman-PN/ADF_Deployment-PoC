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
                    "notebook_path": "/Workspace/ELP-DAB_DEPLOY/databricks_bundle/files/databricks_bundle/resources/notebooks/Notebook1.ipynb",
                    "source": "WORKSPACE",
                },
                "existing_cluster_id": "1017-154210-95uerbaw",
            },
        ],
        "queue": {
            "enabled": True,
        },
    }
)