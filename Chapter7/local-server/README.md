# Local server for Chapter 7

This folder contains code for two different servers. One is a websocket server that you can optionally use to experiment with websockets. The other is a static file server.

## Running the static file server

Open this folder in your terminal and run the following command

```
python3 -m http.server 8080
```

This will run a static file server on port 8080.

The `cars.csv` file was copied from https://github.com/abhionlyone/us-car-models-data which is a free dataset containing tons of information on US cars.

## Running the websocket server

The websocket server in this project uses node.js as its runtime. If you don't have node.js installed, you can do that through [this website](https://nodejs.org/en/download). If you can't or don't want to install node.js you can follow along in the chapter on a theory level instead. The server is only needed if you want to run some experiments of your own.

Once you have node.js installed you can run the server by running the following command in the `simple_socket` folder in your terminal

```
node index.mjs
```