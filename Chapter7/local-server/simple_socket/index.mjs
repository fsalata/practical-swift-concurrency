#!/usr/bin/node

import WebSocket, { WebSocketServer } from 'ws';

const wss = new WebSocketServer({port: 9090});

wss.on('connection', function connection(wss) {
    wss.on('message', function message(data) {
        console.log('received %s', data);
        wss.close();
    });

    wss.send('connection received');

    var t = setInterval(function() {
        var num = Math.random() * 1000;
        console.log("sending message "+num);
        wss.send('sending message! '+num);
    }, 1000);

    wss.on('close', function close() {
        console.log("received close");
        clearInterval(t);
      });
});



