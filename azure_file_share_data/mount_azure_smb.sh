# Note: script requires sudo permissions and STORAGE_ACCOUNT, STORAGE_ACCOUNT_KEY, and SHARE_NAME environment variables

MOUNT_DIR=/mount/${SHARE_NAME}
CRED_FILE=/etc/smbcredentials/${STORAGE_ACCOUNT}.cred

# Create mount folder
sudo mkdir ${MOUNT_DIR}

# Write local credentials
if [ ! -d "/etc/smbcredentials" ]; then
sudo mkdir /etc/smbcredentials
fi

if [ ! -f "${CRED_FILE}" ]; then
    sudo bash -c 'echo "username=${STORAGE_ACCOUNT}" >> ${CRED_FILE}'
    sudo bash -c 'echo "password=${STORAGE_ACCOUNT_KEY}" >> ${CRED_FILE}'
fi
sudo chmod 600 ${CRED_FILE}

# Mount drive when logging in
#sudo bash -c 'echo "//${STORAGE_ACCOUNT}.file.core.windows.net/${SHARE_NAME} ${MOUNT_DIR} cifs nofail,vers=3.0,credentials=${CRED_FILE},dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'

# Mount drive in current session
sudo mount -t cifs //${STORAGE_ACCOUNT}.file.core.windows.net/${SHARE_NAME} ${MOUNT_DIR} -o vers=3.0,credentials=${CRED_FILE},dir_mode=0777,file_mode=0777,serverino
