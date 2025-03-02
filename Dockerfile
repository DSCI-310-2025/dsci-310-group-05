FROM ubcdsci/jupyterlab:v0.9.0

COPY environment.yml .

RUN conda install -n base -c conda-forge mamba && \
    mamba env update -n base -f /tmp/environment.yml && \
    conda clean --all -y
    
EXPOSE 8888

CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]