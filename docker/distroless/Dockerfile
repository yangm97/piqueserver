# Build
ARG PYTHONVERSION=3.5
FROM python:$PYTHONVERSION AS build

WORKDIR /app/src/

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY piqueserver/ ./piqueserver/
COPY pyspades/ ./pyspades/
COPY setup.py README.rst ./

# RUN python setup.py install
# RUN pip install /app/src
RUN pip install piqueserver

ARG PYTHONVERSION
RUN find /usr/local/lib/python$PYTHONVERSION/site-packages -name '*.pyc' -delete
RUN piqueserver --copy-config -d /tmp/config

# Runtime
FROM gcr.io/distroless/python3

ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH /site-packages

ARG PYTHONVERSION
COPY --from=build /usr/local/lib/python$PYTHONVERSION/site-packages /site-packages

COPY --from=build /tmp/config /config
VOLUME /config

CMD ["-m", "piqueserver", "-d", "/config"]
EXPOSE 32887/udp 32887 32886 32885
