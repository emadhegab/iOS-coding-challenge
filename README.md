## GALWeather:

a new smart way to get your weather updates

#### Network:
the network manager is depend on my Pod called [MHNetwork](http://github.com/emadhegab/MHNetwork) it's a simple network manager I created couple of weeks ago to avoid big fat singleton Network managers and be more free and SOLID in creating the network task.

#### Architecture:
   The architecture in the app is based on [VIPER](https://www.objc.io/issues/13-architecture/viper/) architecture.. it's a little Lego like architecture.. but yet so flexible and easy to maintain .. after couple of days of using it you can easily know where the bug is coming in your code. based on my experience with it for 3 years.. the maintainability is higher that ever and Viper teams always faster than others.

### Usage:
  `iPhone:` Press the button and say the query .. just make sure to have the word `(in {City name})` at the end of the sentence other wise the backend will give you the closest match to the last words or will give you nothing

  `WatchOS` will be determined





  ### TODOs:
    -[ ] apple watch integration
    -[ ] SiriKit integration
    -[ ] Today Extension integration
