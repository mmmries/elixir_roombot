# ElixirRoombot

A starter kit for driving a roombot with Elixir.

## Controlling the Roombot Simulator

There is a roombot simulator on http://roombots.riesd.com/.
Once you have started a simulation it will tell you the name of the channel you need to connect to.
Now clone this repository to your computer and do the following:

```
cd elixir_roombot
mix do deps.get, compile
mix drive roombots.riesd.com <your-channel-here>
```

This will fire up `ElixirRoomobt` and you should see some messages about connecting and joining the channel.
Now you can start to customize the main `lib/elixir_roombot.ex` file to make your code control the roombot however you like.

## Controlling a Real Roombot

Real roombots always use the channel `roomba` for controlling and getting sensor updates.
You will need to find out that IP address of the roombot you want to control.
You can [check the recent list](http://roombots.riesd.com/bots) online.
Once you have an IP address just run this project like:

```
mix drive <ip-address-of-roombot> roomba
```

Best of luck!
