*** How to get build.sh to run on Tiny Core Linux ***

Load up Tiny Core Linux and open terminal and run these commands

tce-load -wi openssl
tce-load -wi wget
tce-load -wi libzstd
wget https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/build.sh
chmod 777 build.sh
./build.sh
