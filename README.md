# jlucrypto
ctf crypto environment for jlu,(sagemath,pwntools,gmpy2.....)

# useage
the inital password is `jlucrypto`.
if you want to change password,all you need to do is change the configuration in 

`jupyter_notebook_config.py`

you need to change `c.NotebookApp.password` (which is sha1 hash of  your own password)

you can get sha1 hash  through `from notebook.auth import passwd;password()` 
then rebuild through Dockerfile in this repo.

# links
- reference： https://github.com/hyperreality/cryptohack-docker 
- dockerhub： https://hub.docker.com/r/badmonkey7/jlucrypto

