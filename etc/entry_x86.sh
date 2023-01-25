#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true  

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
                +login anonymous \
                +app_update "${STEAMAPPID}${STEAMAPPBETA:+ -beta }${STEAMAPPBETA}" \
                +quit

# Believe it or not, if you don't do this srcds_run shits itself
cd "${STEAMAPPDIR}"

exec "${STEAMAPPDIR}/srcds_run" -game "${STEAMAPP}" -console -autoupdate \
            -steam_dir "${STEAMCMDDIR}" \
            -steamcmd_script "${HOMEDIR}/${STEAMAPP}_update.txt" \
            -usercon \
            +fps_max "${SRCDS_FPSMAX}" \
            -tickrate "${SRCDS_TICKRATE}" \
            -port "${SRCDS_PORT}" \
            +tv_port "${SRCDS_TV_PORT}" \
            +clientport "${SRCDS_CLIENT_PORT}" \
            +maxplayers "${SRCDS_MAXPLAYERS}" \
            +map "${SRCDS_STARTMAP}" \
            +sv_setsteamaccount "${SRCDS_TOKEN}" \
            +rcon_password "${SRCDS_RCONPW}" \
            +sv_password "${SRCDS_PW}" \
            +sv_region "${SRCDS_REGION}" \
            -ip "${SRCDS_IP}" \
            +host_workshop_collection "${SRCDS_HOST_WORKSHOP_COLLECTION}" \
            -authkey "${SRCDS_WORKSHOP_AUTHKEY}" \
            "${ADDITIONAL_ARGS}"
