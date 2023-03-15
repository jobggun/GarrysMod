###########################################################
# Dockerfile that builds a TF2 Gameserver
###########################################################
FROM cm2network/steamcmd:root AS build_stage

RUN set -x \
    # Add i386 architecture
    && dpkg --add-architecture i386 \
    # Install, update & upgrade packages
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget=1.21-1+deb11u1 \
        ca-certificates=20210119 \
        lib32z1=1:1.2.11.dfsg-2+deb11u2 \
        libncurses5:i386=6.2+20201114-2 \
        libbz2-1.0:i386=1.0.8-4 \
        libtinfo5:i386=6.2+20201114-2 \
        libcurl3-gnutls:i386=7.74.0-1.3+deb11u3 \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

FROM build_stage AS bullseye_x86

ENV STEAMAPPID=4020
ENV STEAMAPP=garrysmod
ENV STEAMAPPBETA=
ENV STEAMAPPDIR="${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL=https://raw.githubusercontent.com/jobggun/GarrysMod

RUN set -x \
    && mkdir -p "${STEAMAPPDIR}" \
    # Add entry script
    && wget "${DLURL}/master/etc/entry_x86.sh" -O "${HOMEDIR}/entry.sh" \
    # Create autoupdate config
    && { \
        echo '@ShutdownOnFailedCommand 1'; \
        echo '@NoPromptForPassword 1'; \
        echo 'force_install_dir '"${STEAMAPPDIR}"''; \
        echo 'login anonymous'; \
        echo 'app_update '"${STEAMAPPID}${STEAMAPPBETA:+ -beta }${STEAMAPPBETA}"''; \
        echo 'quit'; \
       } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
    && chmod +x "${HOMEDIR}/entry.sh" \
    && chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt"

ENV SRCDS_FPSMAX=300 \
    SRCDS_TICKRATE=100 \
    SRCDS_PORT=27015 \
    SRCDS_TV_PORT=27020 \
    SRCDS_IP="0" \
    SRCDS_MAXPLAYERS=16 \
    SRCDS_TOKEN=0 \
    SRCDS_RCONPW="changeme" \
    SRCDS_PW="changeme" \
    SRCDS_STARTMAP="gm_construct" \
    SRCDS_REGION=3 \
    SRCDS_HOSTNAME="New \"${STEAMAPP}\" Server" \
    SRCDS_HOST_WORKSHOP_COLLECTION=0 \
    SRCDS_WORKSHOP_AUTHKEY="" \
    ADDITIONAL_ARGS=""

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 27015/tcp \
       27015/udp \
       27020/udp

FROM build_stage AS bullseye_x86-64

ENV STEAMAPPID=4020
ENV STEAMAPP=garrysmod
ENV STEAMAPPBETA=x86-64
ENV STEAMAPPDIR="${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL=https://raw.githubusercontent.com/jobggun/GarrysMod

RUN set -x \
    && mkdir -p "${STEAMAPPDIR}" \
    # Add entry script
    && wget "${DLURL}/master/etc/entry_x86-64.sh" -O "${HOMEDIR}/entry.sh" \
    # Create autoupdate config
    && { \
        echo '@ShutdownOnFailedCommand 1'; \
        echo '@NoPromptForPassword 1'; \
        echo 'force_install_dir '"${STEAMAPPDIR}"''; \
        echo 'login anonymous'; \
        echo 'app_update '"${STEAMAPPID}${STEAMAPPBETA:+ -beta }${STEAMAPPBETA}"''; \
        echo 'quit'; \
       } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
    && chmod +x "${HOMEDIR}/entry.sh" \
    && chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt"

ENV SRCDS_FPSMAX=300 \
    SRCDS_TICKRATE=100 \
    SRCDS_PORT=27015 \
    SRCDS_TV_PORT=27020 \
    SRCDS_IP="0" \
    SRCDS_MAXPLAYERS=16 \
    SRCDS_TOKEN=0 \
    SRCDS_RCONPW="changeme" \
    SRCDS_PW="changeme" \
    SRCDS_STARTMAP="gm_construct" \
    SRCDS_REGION=3 \
    SRCDS_HOSTNAME="New \"${STEAMAPP}\" Server" \
    SRCDS_HOST_WORKSHOP_COLLECTION=0 \
    SRCDS_WORKSHOP_AUTHKEY="" \
    ADDITIONAL_ARGS=""

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 27015/tcp \
       27015/udp \
       27020/udp
