@echo off
set WSL_IP=172.23.117.225

netsh interface portproxy add v4tov4 listenport=9001 listenaddress=0.0.0.0 connectport=9001 connectaddress=%WSL_IP%
netsh interface portproxy add v4tov4 listenport=9002 listenaddress=0.0.0.0 connectport=9002 connectaddress=%WSL_IP%
netsh interface portproxy add v4tov4 listenport=9003 listenaddress=0.0.0.0 connectport=9003 connectaddress=%WSL_IP%