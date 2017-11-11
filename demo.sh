#/usr/bin/env bash

setup() {
    go install ./vuvuzela-client ./vuvuzela-entry-server ./vuvuzela-server
    cp -r ./confs $GOPATH/bin
}

start() {
    cd $GOPATH/bin
    echo "--> starting the last server.."; sleep 3
    screen -d -m -S last ./vuvuzela-server -conf confs/local-last.conf
    echo "--> starting the middle server.."; sleep 3
    screen -d -m -S middle ./vuvuzela-server -conf confs/local-middle.conf
    echo "--> starting the first server.."; sleep 3
    screen -d -m -S first ./vuvuzela-server -conf confs/local-first.conf
    echo "--> starting the entry server.."; sleep 3
    screen -d -m -S entry ./vuvuzela-entry-server -wait 1s
    echo "--> starting the client alice.."; sleep 3
    screen -d -m -S alice ./vuvuzela-client -conf confs/alice.conf
    echo "Done."
}

start
