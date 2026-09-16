#!/bin/bash
OS=`uname -s`
HOSTNAME=`hostname`
if [ "$OS" = "Darwin" ]; then
    BOOT_TIME=`sysctl -n kern.boottime | sed -n 's/.*{ *sec *= *\([0-9]*\).*/\1/p'`
    UPTIME=$(($(date +%s) - $BOOT_TIME))
    DISTRO="macOS `sw_vers -productVersion`"
    PAGE_SIZE=`getconf PAGESIZE`
    RAM_TOTAL=`sysctl -n hw.memsize | awk '{print int($1 / 1048576)}'`
    FREE_PAGES=`vm_stat | awk '/Pages free/ {print $3}'`
    FREE_MB=$(awk -v f="$FREE_PAGES" -v p="$PAGE_SIZE" 'BEGIN {print int(f * p / 1048576)}')
    RAM_USED=$((RAM_TOTAL - FREE_MB))
else
    UPTIME=`awk '{print $1}' /proc/uptime`
    DISTRO=`cat /etc/*release | grep "PRETTY_NAME" | cut -d "=" -f 2- | sed 's/"//g'`
    RAM_TOTAL=`free -t --mega | grep "Mem" | awk {'print $2'}`
    RAM_USED=`free -t --mega | grep "Mem" | awk {'print $3'}`
fi
DISK_DATA=`df -m / | tail -n 1`
DISK_TOTAL=`echo $DISK_DATA | awk {'print $2'}`
DISK_USED=`echo $DISK_DATA | awk {'print $3'}`

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