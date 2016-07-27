const fs = require("fs")

fs.readFile("common-mistakes.txt", "ascii", function (err, data) {
	if (err) throw err;
	const mistakes = data

	var mistakesOnly = []
	mistakes.replace(/\b[\w' ;]+(?=->)/g, function (str) {
		mistakesOnly.push(str)
	})

	var mistakesLineByLine = mistakes.split("\n")
	var originalWords = []

	fs.writeFile("mistakesonly.txt", mistakesOnly.join("\n"))

	for (var i = 0; i < mistakesLineByLine.length; i++) {
		var replaced = mistakesLineByLine[i].replace(mistakesOnly[i] + "->", "")
		originalWords.push(replaced)
	}

	fs.writeFile("originalwords.txt", originalWords.join("\n"))

	var revSpellcheck = {}
	for (var j = 0; j < mistakesOnly.length; j++) {
		revSpellcheck[originalWords[j]] = mistakesOnly[j]
	}

	revSpellcheck = expand(revSpellcheck)

	fs.writeFile("reverseSpellcheck.json", JSON.stringify(revSpellcheck))
})

function expand(obj) {
    var keys = Object.keys(obj);
    for (var i = 0; i < keys.length; ++i) {
        var key = keys[i],
            subkeys = key.split(/,\s?/),
            target = obj[key];
        delete obj[key];
        subkeys.forEach(function(key) { obj[key] = target; })
    }
    return obj;
}