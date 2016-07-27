# Misspell
This is a JavaScript reverse spellchecker. It takes words and screws up the spelling and capitalisation.

## Usage
Include `misspell.js` in your project with a `<script>` tag or via `npm install misspell`. Then you can require it and use it right away!

```
var misspell = require("misspell") // if you haven't included it with a script tag

var misspelledText = misspell(text, capitalisation[, capsTypes])
// text: the string you would like to process
// capitalisation: boolean, set this to true or false depending on if you want the capitalisation to be changed.
// capsTypes (optional): an array of the capitalisation modes you want to enable. of the array of modes you supply, a random mode will be chosen. if you don't supply an array of specific modes, a random mode will be chosen out of every possible mode.
    // LIST OF CAPITALISATION MODES
    // mode 1: jaden smith mode, capitalises the first letter of each word in the string
    // mode 2: random jaden smith mode, sometimes capitalises the first letter of randomly picked words from the string
    // mode 3: uppercase mode, makes whole string uppercase
    // mode 4: lowercase mode, makes whole string lowercase
    // mode 5: totally screwed up mode, each character is randomly made uppercase or lowercase
    // mode 6: "tumblr" mode, begins a string normally and eventually at a random place goES INTO ALL CAPS AND CONTINUES TO BE ALL CAPS UNTIL THE END OF THE STRING
// an example of a value you can supply for capsTypes is [1, 3, 5], which only allows jaden smith mode, uppercase mode, and totally screwed up mode.
```

You can also play around with `misspell.js` like a CLI. Run it with `node` and pass the same arguments you'd pass to it as a function in the same order and it'll pipe out the result.