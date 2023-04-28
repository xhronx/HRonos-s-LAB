# /bin/ bash
# GRAYLOG AFTER INSTALL 

# !!!!!!

# Генерация GRAYLOG_ROOT_PASSWORD_SHA2 из пароля администратора
echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f11~

