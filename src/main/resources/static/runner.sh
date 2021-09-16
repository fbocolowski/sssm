#!/bin/bash
UPTIME=`awk '{print $1}' /proc/uptime`
HOSTNAME=`hostname`
DISTRO=`cat /etc/*release | grep "PRETTY_NAME" | cut -d "=" -f 2- | sed 's/"//g'`
RAM_TOTAL=`free -t --mega | grep "Mem" | awk {'print $2'}`
RAM_USED=`free -t --mega | grep "Mem" | awk {'print $3'}`
DISK_DATA=`df -m --output=target,pcent,size,used / | tail -n+2`
DISK_TOTAL=`echo $DISK_DATA | awk {'print $3'}`
DISK_USED=`echo $DISK_DATA | awk {'print $4'}`

generate_post_data() {
cat <<EOF
{
    "uptime": "$UPTIME",
    "hostname": "$HOSTNAME",
    "distro": "$DISTRO",
    "ramTotal": "$RAM_TOTAL",
    "ramUsed": "$RAM_USED",
    "diskTotal": "$DISK_TOTAL",
    "diskUsed": "$DISK_USED"
}
EOF
}

curl -X POST \
-H "Server-Token: $2" \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-d "$(generate_post_data)" \
-s "$1/api/reports" > /dev/null