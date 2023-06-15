Download Mambaforge, this is a self-contained distribution of Python based on [Conda](https://docs.conda.io/).

```
curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
bash Mambaforge-Linux-x86_64.sh -b
```{{exec}}

Activate the mambaforge environment
`. ~/mambaforge/bin/activate`{{exec}}

And install Ansible
`mamba install -y -c conda-forge ansible=6`{{exec}}
