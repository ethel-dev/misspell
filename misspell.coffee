# misspell 1.1.1
# by ethan arterberry

revspellcheck = require "./reverse-spellcheck.json"
path = require "path"

misspell = (text, caps, capsTypes, misspellPercent) ->
    words = text.split " "

    # pick capitalisation mode
    if capsTypes? # if user has defined capitalisation modes they want pick one from them
        capsType = capsTypes[misspell.random(0, capsTypes.length)] 
    else # if not just pick a random one
        capsType = misspell.random(1, 7)

    newWords = []
    startCaps = null

    # default misspellchance
    if misspellPercent? then null else misspellPercent = 10

    for word, w in words
        letters = word.split ""

        # pick two random words from the string. if the random words match, time to misspell a word!
        if misspell.random(0, 101) <= misspellPercent
            misspellType = misspell.random(1, 3) # pick number between 1 and 3 to pick a random misspell mode
            switch misspellType
                when 1
                    # simple swap (swap two letters next to each other)
                    letterToSwapIndex = misspell.random(0, letters.length - 1)
                    letterToSwap = letters[letterToSwapIndex]
                    letters[letterToSwapIndex] = letters[letterToSwapIndex + 1]
                    letters[letterToSwapIndex + 1] = letterToSwap
                when 2
                    # misspell dictionary
                    if revspellcheck[word]? # if current word has a misspelling in the file reverse-spellcheck.json, misspell it
                        words[w] = revspellcheck[word]
                    else
                        for wordx, x in words
                            if revspellcheck[wordx]?
                                words[x] = revspellcheck[wordx]
                                break
                       

        if caps is true
            if startCaps isnt true
                switch capsType
                    when 1
                        # jaden
                        letters[0] = letters[0].toUpperCase()
                    when 2
                        # random jaden
                        if misspell.random(0, 2) is 0
                            letters[0] = letters[0].toUpperCase()
                    when 3
                        # upper
                        letters = letters.join("").toUpperCase().split("")
                    when 4
                        # lower
                        letters = letters.join("").toLowerCase().split("")
                    when 5
                        # totally screwed up
                        for letter, i in letters
                            randomCapLetter = misspell.random(0, 3)
                            if letters[i]?
                                switch randomCapLetter
                                    when 0
                                        letters[i] = letter.toUpperCase()
                                    when 1
                                        letters[i] = letter.toLowerCase()

                    when 6
                        # tumblr
                        for letter, i in letters
                            # pick two random numbers between 0 and the text length, and if they match begin tumblr mode
                            if misspell.random(0, text.length) is misspell.random(0, text.length) and startCaps isnt true
                                startCaps = true # this is in place so future loops won't redo any part of this script redundantly
                                upperPartOfWord = letters.slice(i, letters.length).join("").toUpperCase().split("") # take final part of word from current letter on, and make it uppercase and an array
                                letters = letters.slice(0, i).concat(upperPartOfWord) # merge the lowercase and uppercase part of the word
            else if startCaps is true
                # if tumblr mode is active just skip the BS and caps lock the rest
                letters = letters.join("").toUpperCase().split("")

        newWords.push(letters.join(""))

    return newWords.join(" ")

misspell.random = (min, max) ->
    return Math.floor(Math.random() * (max - min)) + min

# allows misspell to work as a module
module.exports = misspell

# ghetto CLI
if path.basename(process.argv[1]) is "misspell.js"
    if process.argv[5]?
        console.log misspell(String(process.argv[2]), (String(process.argv[3]) is "true"), JSON.parse(process.argv[4]), Number(process.argv[5]))
    else if process.argv[4]?
        console.log misspell(String(process.argv[2]), (String(process.argv[3]) is "true"), JSON.parse(process.argv[4]))
    else if process.argv[3]?
        console.log misspell(String(process.argv[2]), (String(process.argv[3]) is "true"))
    else if process.argv[2]?
        console.log misspell(String(process.argv[2]), true)
    else if process.argv[1]?
        console.log "You just ran Misspell without any arguments. You can use Misspell like a CLI if you'd like, just put the arguments in the same order you would using it in JavaScript."