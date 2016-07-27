misspell = require("misspell")
const test = misspell("The quick brown fox jumped over the lazy dog.", true)

if (test !== undefined) {
	console.log("Misspell is working.")
}