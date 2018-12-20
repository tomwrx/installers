## Pre-requisites
```
#GIT and Compiler dependencies
sudo apt update
sudo apt upgrade
sudo apt install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git
sudo apt install -y g++-mingw-w64-x86-64
sudo apt install -y unzip

#AEM Dependencies
sudo apt install -y jq software-properties-common curl
sudo apt update > /dev/null 2>&1
sudo apt install -y pwgen build-essential libssl-dev libboost-all-dev libqrencode-dev libminiupnpc-dev
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt update
sudo apt install -y libdb5.3-dev libdb5.3++-dev
sudo apt install -y libzmq5 libboost-system1.58.0 libboost-filesystem1.58.0 libboost-program-options1.58.0 libboost-thread1.58.0 libboost-chrono1.58.0 libminiupnpc10 libevent-pthreads-2.0-5 unzip

# QT Libs and files
sudo apt-get install -y libqt5webkit5-dev qtscript5-dev libqt5help5 qttools5-dev qtdeclarative5-private-dev qtdeclarative5-dev-tools qtbase5-private-dev libqt5xmlpatterns5-dev qtxmlpatterns5-dev-tools qttools5-dev-tools
```

## Compiling for WINDOWS x32:
### ONLY GOT THIS TO WORK ON UBUNTU 14.04 !!!
```
sudo update-alternatives --config x86_64-w64-mingw32-g++ #POSIX will be the default one
cd Atheneum/depends/
make HOST=x86_64-w64-mingw32
cd ..
./autogen.sh
CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/opt/local --with-incompatible-bdb
make
```

## Compiling for WINDOWS x64:
### ONLY GOT THIS TO WORK ON UBUNTU 14.04 !!!
```
sudo update-alternatives --config x86_64-w64-mingw32-g++ #POSIX will be the default one
cd Atheneum/depends/
make HOST=i686-w64-mingw32
cd ..
./autogen.sh
CONFIG_SITE=$PWD/depends/i686-w64-mingw32/share/config.site ./configure --prefix=/ --with-incompatible-bdb
make
```

## Compiling for Ubuntu        
### ONLY GOT THIS TO WORK ON UBUNTU 16.04 !!!
See https://github.com/PIVX-Project/PIVX/blob/master/doc/build-unix.md
```
cd Atheneum
./autogen.sh
./configure #(if you want to build daemon, use --without-gui)
make
```

## Compiling for Mac OS


## Harcoding Seeds
### Pre-requisites:
```
sudo apt-get install python3-dnspython
```

### Procedure
```
cd contrib/seeds
nano nodes_main.txt
```
enter all of the seeds in the format ```x.x.x.x:22000``` one per line. Save and exit
```
touch nodes_test.txt
python3 generate-seeds.py . > ../../src/chainparamsseeds.h
```

Then recompile the wallet(s)