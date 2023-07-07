FROM python:3.8-slim-buster as langchain-serve-img

RUN pip install -U pip
RUN pip config set global.index-url https://mirrors.huaweicloud.com/repository/pypi/simple
RUN pip config set install.trusted-host mirrors.huaweicloud.com
RUN pip3 config set global.index-url https://mirrors.huaweicloud.com/repository/pypi/simple
RUN pip3 config set install.trusted-host mirrors.huaweicloud.com

RUN echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib" > /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian-security buster/updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian-security buster/updates main" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list


RUN pip3 install --default-timeout=100 langchain-serve
RUN pip3 install --default-timeout=100 api

CMD [ "lc-serve", "deploy", "local", "api" ]

FROM python:3.8-slim-buster as pdf-gpt-img

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install --default-timeout=100 --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python3", "app.py" ]
