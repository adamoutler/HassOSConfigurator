#!/usr/bin/with-contenv bashio

set +e

fun() { while true; do nc -l -p 8099 -e echo -e 'HTTP/1.1 200 OK\r\nServer: DeskPiPro\r\nDate:$(date)\r\nContent-Type: text/html; charset=UTF8\r\nCache-Control: no-store, no cache, must-revalidate\r\n\r\n<!DOCTYPE html><html><body><p>This addon gains 2 security points for implementing this page. So it is here.</body></html>\r\n\n\n'; done; }
fun &

key=$(jq -r '.SSHKey' options.json)

mountAttempts=0
mountFailures=0

copyKeyToDevicePartition() {
  partition="/dev/${1}"
  tmp_path="/tmp/${1}"
  config_dir="${tmp_path}/CONFIG"
  authorized_keys_file="${config_dir}/authorized_keys"

  if [ ! -e "${partition}" ]; then
    echo "[skip] ${partition} does not exist."
    return
  fi

  mkdir -p "${tmp_path}" 2>/dev/null
  mountAttempts=$((mountAttempts + 1))
  mount "${partition}" "${tmp_path}" 2>/dev/null

  # NOTE: This check must be run immediately after the `mount` command above.
  if [ $? -ne 0 ]; then
    mountFailures=$((mountFailures + 1))
    return
  fi

  if [ ! -e "${tmp_path}/cmdline.txt" ]; then
    echo "[skip] No config file found in ${partition}"
    return
  fi

  if test -e "${config_dir}/" && grep "$key" "${authorized_keys_file}" >/dev/null 2>&1; then
    echo "[skip] Key already exists in ${partition}"
    return
  fi

  echo "Writing authorized_keys in ${partition}"
  mkdir -p "${config_dir}"
  echo "$key" >>"${authorized_keys_file}"
  echo "[SUCCESS] Key written to ${partition}."
}
partitions=(
  vda1
  sda1
  sdb1
  mmcblk0p1
  mmcblk1p1
  nvme0n1p1
  xvda8
)
for partition in "${partitions[@]}"; do
  copyKeyToDevicePartition "${partition}"
done

if [ $mountAttempts -eq $mountFailures ]; then
  echo "============================================================="
  echo "=    #     #    #    ######  #     # ### #     #  #####     ="
  echo "=    #  #  #   # #   #     # ##    #  #  ##    # #     #    ="
  echo "=    #  #  #  #   #  #     # # #   #  #  # #   # #          ="
  echo "=    #  #  # #     # ######  #  #  #  #  #  #  # #  ####    ="
  echo "=    #  #  # ####### #   #   #   # #  #  #   # # #     #    ="
  echo "=    #  #  # #     # #    #  #    ##  #  #    ## #     #    ="
  echo "=     ## ##  #     # #     # #     # ### #     #  #####     ="
  echo "============================================================="
  echo "="
  echo "=   Issue: Failed to mount all attempted partitions (${mountAttempts} partition(s))."
  echo "="
  echo "=   Possible Solution: Ensure that 'Protection mode' is disabled in the 'Info' tab of this Add-On."
  echo "="
  echo "============================================================="
  echo "[FAILURE] Configurator failed. Please follow the steps above, then restart this Add-On."
  sleep 99999
  exit 1
fi

echo "[Done] Configurator complete. Perform a hard power-off now. This configurator only works once and is no longer needed."
sleep 99999
