## GALWeather:

a new smart way to get your weather updates

#### Network:
the network manager is depend on my Pod called [MHNetwork](http://github.com/emadhegab/MHNetwork) it's a simple network manager I created couple of weeks ago to avoid big fat singleton Network managers and be more free and SOLID in creating the network task.

#### Architecture:
   The architecture in the app is based on [VIPER](https://www.objc.io/issues/13-architecture/viper/) architecture.. it's a little Lego like architecture.. but yet so flexible and easy to maintain .. after couple of days of using it you can easily know where the bug is coming in your code. based on my experience with it for 3 years.. the maintainability is higher that ever and Viper teams always faster than others.

### Usage:
  run the app on each schema to see the respectful widget / gadget

  `iPhone:` Press the button and say the query .. just make sure to have one of this words before `["in", "at", "near", "of"]` `({City name})` at the end of the sentence other wise the backend will give you the closest match to the last words or will give you nothing

  `WatchOS` press on the mic icon and choose from the suggestions (static 2 cities) or press the blue mic in there and dictate your request just like iPhone.

  `Today Widget` go to today screen on your iPhone or force touch the app icon.. it's a short cut to open the dictation directly from outside






  ### TODOs:
    -[x] apple watch integration

    -[x] Today Extension integration
    -[ ] SiriKit integration (should wait till I have access to short cut app (still in alpha and not much developers have access to it yet))
