#! /bin/bash
# Копируем ключи SSH на удаленный сервер: 
ssh-copy-id -i /home/user/.ssh/id_ed25529.pub userserver@192.168.0.0

# Копирование файлов на сервере: Через ssh-сессию:
scp path/myfile user@8.8.8.8:/full/path/to/new/location/

# Копирование файлов на сервере: Обратно:
scp user@8.8.8.8:/full/path/to/file /path/to/put/here
