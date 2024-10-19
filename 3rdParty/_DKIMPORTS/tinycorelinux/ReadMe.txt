*** How to get build.sh to run on Tiny Core Linux ***

Load up Tiny Core Linux and open terminal and run these commands

tce-load -wi openssl
tce-load -wi wget
tce-load -wi libzstd
wget https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/build.sh
chmod 777 build.sh
./build.sh



# TinyCoreLinux with QEMU (4 part read)
https://medium.com/@rudra.15beaeg033/tiny-core-linux-with-qemu-part-01-8841902cf9d8
https://medium.com/@rudra.15beaeg033/tiny-core-linux-with-qemu-part-02-3d668ddf3fab
https://medium.com/@rudra.15beaeg033/tiny-core-linux-with-qemu-part-03-94820a849e52
https://medium.com/@rudra.15beaeg033/tiny-core-linux-with-qemu-part-04-77aa8c03fa80