#!/bin/sh

# /var/log/freeradius/radacct tends to grow very large because the logs
# are rotated daily and never cleaned up.  This solves this in
# a twofold way: compressing all logs except todays, and removing
# logs that are older than a specified age.  eduroam requires
# we keep radacct for six months (184 days is safe).

# If there is a global system configuration file, suck it in.
if [ -r /etc/default/freeradius-radacctclean ]; then
	. /etc/default/freeradius-radacctclean
fi
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

: ${FREERADIUS_RADACCT_CLEAN_ENABLE:="YES"}
: ${FREERADIUS_RADACCT_LOGDIR:=/var/log/freeradius/radacct}
: ${FREERADIUS_RADACCT_RETENTION:=184}
: ${FREERADIUS_RADACCT_COMPRESSOR:=xz}
rc=0

case "${FREERADIUS_RADACCT_CLEAN_ENABLE}" in
    [Yy][Ee][Ss])

		# dates
		yesterday=$(date -d "00:00 1 days ago" '+%Y%m%d')
		stale=$(date -d "00:00 ${FREERADIUS_RADACCT_RETENTION} days ago" '+%Y%m%d')

		# Compressing FreeRADIUS radacct logs
		for nas in ${FREERADIUS_RADACCT_LOGDIR}/* ; do
			cd ${nas}
			for log in *; do
				if [ -f ${log} -a ${log} != "*" -a ${log%%.bz2} = ${log} -a ${log%%.xz} = ${log} -a ${log%%.gz} = ${log} ] ; then
					if [ ${log##*detail-} -le ${yesterday} ] ; then
						${FREERADIUS_RADACCT_COMPRESSOR} $log || rc=1
					fi
				fi
			done
		done

		# Removing FreeRADIUS stale radacct logs (<${stale})
		for nas in ${FREERADIUS_RADACCT_LOGDIR}/* ; do
			cd ${nas}
			for log in *.bz2 *.xz *.gz; do
				if [ -f ${log} -a ${log} != "*.bz2" -a ${log} != "*.xz" -a ${log} != "*.gz" ] ; then
					log_munged=${log##*detail-}
					if [ ${log_munged%%.[bx]z*} -lt ${stale} ] ; then
						rm -f ${nas}/${log} || rc=1
					fi
				fi
			done
		done
    ;;

    *)
		echo "To enable, set FREERADIUS_RADACCT_CLEAN_ENABLE=yes in /etc/default/freeradius-radacctclean"
		rc=0;;
esac

exit $rc
