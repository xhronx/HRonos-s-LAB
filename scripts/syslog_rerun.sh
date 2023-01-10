#!/bin/bash
# C помощью команды  kill -SIGNAL `cat /var/run/syslogd.pid` можно послать службе syslogd один из следующих сигналов:
#SIGHUP — перезапуск демона;
#SIGTERM — завершение работы;
#SIGUSR1 — включить/выключить режим отладки.

kill -SIGHUP `cat /var/run/syslogd.pid`
