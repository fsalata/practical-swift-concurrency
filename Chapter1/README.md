# Running the static file server for the movies project

## The short version
Open the `movies` folder in your terminal and run the following command

```
python3 -m http.server 8080
```

You will now have a local static file server that serves the JSON files from the `movies` folder on port 8080.

## The longer version

Use terminal to navigate to the `movies` folder. For example, if you have the book in your computer's home directory, you would navigate to `~/PracticalSwiftConcurrency/code/movies`. In this folder, you can start your local server by typing the following command:

```bash
python3 -m http.server 8080
```

All macs should come with Python pre-installed so you should have no issues running this command. If you do run into issues because you don't have python available, you can install Python yourself via the official [Python website](https://www.python.org/downloads/macos/) or you can run a local server on port 8080 through any other means you have available. For example, if you have node and npm installed you could make use of the http-server package.

When you have your local server running, you have a static file server in the current working directory. In other words, it allows us to access URLs like `http://127.0.0.1:8080/1.json` to access the json files in the movies directory.

With the server running, you’re all good to work on the sample app for this chapter and for other chapters too. Whenever a chapter requires you to leverage our local server I will make sure to remind you to start your local server.

Note that the local server will only be avaialble when you're running the sample code on your mac or if you're runninbg code on the iOS simulator. If you want to run the sample code on your iOS devices you should make sure that:

* Your iPad/phone and mac are on the same network.
* You replace all occurences of `127.0.0.1` in the sample code with your Mac's ip address.

The simplest way to find you're mac's ip address is to open the **System Settings** app on your mac, navigating to the **Network** tab and then click on your active network connection (usually WiFi or Ethernet, it will have a green dot alongside it). This will show you your mac's local ip address that allows you to connect your phone to your mac as long as they're both on the same network. Note that your mac's ip address will be different on a different network and some networks rotate ip addresses so if something's not working, always double check that you're using the right ip address.