FROM apache/airflow:2.5.3-python3.10
# If we want to install system packages
# USER root
# RUN apt-get install -y ....
# Become airflow user for pypi installs
# USER airflow
# Using requirements.txt
# COPY requirements.txt /
# RUN pip install --no-cache-dir -r /requirements.txt
# Individual packages:
RUN pip install --no-cache-dir \
    apache-airflow-providers-trino \
    h5py \
    ConfigArgParse
    # With Slim
    # apache-airflow-providers-celery \
    # apache-airflow-providers-cncf-kubernetes \
    # apache-airflow-providers-google \
    # apache-airflow-providers-postgres \
    # apache-airflow-providers-redis \ 
    # Authlib
