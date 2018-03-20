# Hangman Live Coding

In a new directory run:

- yarn add create-elm-app
- create-elm-app hangman
- (Copy the Main.elm & main.css from this repository into hangman/src)
- cd hangman
- elm-app start

Navigate to localhost:3000 as suggested by the elm-app output.

Thanks to Lambda Lounge for hosting and to everyone that attended!


## Follow Up Exercises

- Figure out how & when to switch the `gameState` to `Won` and `Lost`
- Switch to using an Http call to: https://snapdragon-fox.glitch.me/level which
  returns a `word` and a `difficulty` level. Figure out how to adapt the Json
  Decoder for that and use the `difficulty` to adjust how many failed guesses
  the played gets before losing.
- Create your own API by forking: https://glitch.com/edit/#!/snapdragon-fox to
  add other elements to the game or play with more deeply nested Json Decoders.
- Create some images of the various stages of the progress of the hangman and
  switch between them based on how many failed guesses the played has had.


## Links

- [Lambda Lounge Twitter](https://twitter.com/lambdamcr)
- [Elm Manchester Twitter](https://twitter.com/elm_manchester)
- [Michael's Twitter](https://twitter.com/michaelpjones)
- [Elm Manchester Meetup Group](https://www.meetup.com/elm-manchester)
- [Elm Manchester Resources List](https://github.com/michaeljones/elm-manchester-resources)
- [Purescript](http://www.purescript.org/)

I recommend watching some of the talks from the Resources List above. Particularly those from Evan
Czaplicki who is the author of Elm. It is important to understand his perspective to understand why
Elm is the way it is.


## Sponsorship

Elm Manchester is sponsorsed by Zaptic where we use Elm in production. We're hiring :)
