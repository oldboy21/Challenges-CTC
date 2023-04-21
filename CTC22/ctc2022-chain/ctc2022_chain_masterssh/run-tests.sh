echo "Running test APIs"
curl --show-error --fail -m 20 -s -X POST -H 'Origin: 192.168.32.1' -d "train=sprinter&company=NS&price=1389&accepted=true" http://10.6.0.3:8080/demo/ctc -o /dev/null
sleep 1
curl --show-error --fail -m 20 -s -X POST -H 'Origin: 255.255.255.0' -d "train=intercitydirect&company=NS&price=8080&accepted=false" http://10.6.0.3:8080/demo/ctc -o /dev/null
sleep 1
curl --show-error --fail -m 20 -X POST -H 'Origin: 127.0.0.1' -d "train=tram&company=HTA&price=21&accepted=true" http://10.6.0.3:8080/demo/ctc -o /dev/null
echo "Retrieving some logs for debugging"
sleep 1
wget http://10.6.0.3:8080/demo/stuff -O application.log
