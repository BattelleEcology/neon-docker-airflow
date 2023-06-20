FROM apache/airflow:2.6.2-python3.11

# Set bash strict mode
SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-x", "-c"]

# Install apt-get packages
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        # We need jq for the api user scripting, don't remove it
        jq \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER airflow

# Several airflow components need the gcloud sdk installed, so lets do it
# This varies from the airflow example docs in that it doesn't install the sdk as the root user
# ARG CLOUD_SDK_VERSION=425.0.0
# ENV GCLOUD_HOME="/home/airflow/google-cloud-sdk"
# ENV PATH="${GCLOUD_HOME}/bin:${PATH}"
# RUN DOWNLOAD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" \
#     && TMP_DIR="$(mktemp -d)" \
#     && curl -fL "${DOWNLOAD_URL}" --output "${TMP_DIR}/google-cloud-sdk.tar.gz" \
#     && mkdir -p "${GCLOUD_HOME}" \
#     && tar xzf "${TMP_DIR}/google-cloud-sdk.tar.gz" -C "${GCLOUD_HOME}" --strip-components=1 \
#     && "${GCLOUD_HOME}/install.sh" \
#        --bash-completion=false \
#        --path-update=false \
#        --usage-reporting=false \
#        --additional-components alpha beta kubectl gke-gcloud-auth-plugin \
#        --quiet \
#     && rm -rf "${TMP_DIR}" \
#     && rm -rf "${GCLOUD_HOME}/.install/.backup/" \
#     && gcloud --version

# Using requirements.txt
# COPY requirements.txt /
# RUN pip install --no-cache-dir -r /requirements.txt
# Individual packages:
RUN pip install --upgrade --no-cache-dir \
    apache-airflow-providers-trino==5.0.0 \
    h5py \
    ConfigArgParse

