#===========================
#本地使用方式 
#1.首先build一个镜像,在dockerfile 目录下直接 docker build -t badmonkey:jlucrypto .
#2.创建一个容器,docker run -d -p 9999:8888 badmonkey:jlucrypto (9999端口被占用的话,改一个就行了,根据需要来)
#3.打开浏览器 输出http:127.0.0.1:9999 就可以快乐的使用了sagemath了.
#dockhub
#https://hub.docker.com/r/badmonkey7/jlucrypto
#===========================

FROM sagemath/sagemath:latest
#===========================
# 将同目录下的配置文件拷贝到容器中,更换apt,pip源为清华源
#===========================
ADD sources.list /etc/apt/
COPY pip.conf /etc/pip.conf


#==========================
# 安装vim，netcat等工具及build环境
#==========================
USER root

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
    netcat \
    tmux \
    vim \
    && rm -rf /var/lib/apt/lists/*
	

#==========================
# 安装python package
#==========================
USER sage

RUN /home/sage/sage/local/bin/pip install --no-cache-dir \
    pwntools \
    pycryptodome \
    z3-solver 

#====================================
# 配置信息,可以直接在jupyter_notebook_config.py中修改,不需要密码的话,可以直接注释掉下一句代码(默认密码为jlucrypto)
#====================================
COPY jupyter_notebook_config.py  ./sage/local/etc/jupyter/jupyter_notebook_config.py

#===================================
# css 样式,还是觉得原生的好看一些.
#===================================
# COPY --chown=sage:sage custom.css /home/sage/.sage/jupyter-4.1/custom/custom.css

#==========================
# pwntools 环境变量配置
#==========================
ENV PWNLIB_NOTERM=true


CMD ["sage -n jupyter --NotebookApp.token='' --no-browser --ip='0.0.0.0' --port=8888"]

