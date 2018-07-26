# This is the development friendly Dockerfile.
# For production-ready Dockerfiles, see docker/

ARG PYTHON_VERSION=3.6
ARG APPDIR=/app

FROM python:$PYTHON_VERSION

ARG APPDIR
ENV APPDIR ${APPDIR}
RUN python -m venv ${APPDIR}
ENV PATH "${APPDIR}/bin:${PATH}"

CMD pip --no-cache-dir install -e ${APPDIR}/src && \
    piqueserver -d /config
