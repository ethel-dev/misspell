# misspell 0.1
# by ethan arterberry

revspellcheck = require "./reverse-spellcheck.json"

misspell = (text, caps, capsTypes) ->
    words = text.split " "
    if capTypes? then capsType = capsTypes[misspell.random(0, capsTypes.length)] else capsType = misspell.random(1, 7)
    misspellType = misspell.random(1, 3)
    newWords = []
    startCaps = null
    for word, w in words
        letters = word.split ""

        # pick two random words from the string. if the random words match, time to misspell a word!
        if words[misspell.random(0, words.length)] == words[misspell.random(0, words.length)]
            switch misspellType
                when 1
                    # simple swap
                    letterToSwapIndex = misspell.random(0, letters.length - 1)
                    letterToSwap = letters[letterToSwapIndex]
                    letters[letterToSwapIndex] = letters[letterToSwapIndex + 1]
                    letters[letterToSwapIndex + 1] = letterToSwap
                when 2
                    # misspell dictionary
                    if revspellcheck[word]?
                        words[w] = revspellcheck[word]
                    else
                        for wordx, x in words
                            if revspellcheck[wordx]?
                                words[x] = revspellcheck[wordx]

        if caps == true
            if startCaps != true
                switch capsType
                    when 1
                        # jaden
                        letters[0] = letters[0].toUpperCase()
                    when 2
                        # random jaden
                        if misspell.random(0, 2) == 0
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
                            switch randomCapLetter
                                when 0
                                    letters[i] = letter.toUpperCase()
                                when 1
                                    letters[i] = letter.toLowerCase()
                    when 6
                        # tumblr
                        for letter, i in letters
                            if misspell.random(0, text.length) == misspell.random(0, text.length) and startCaps != true
                                startCaps = true
                                upperPartOfWord = letters.slice(i, letters.length)
                                for letter, j in upperPartOfWord
                                    upperPartOfWord[j] = letter.toUpperCase()
                                letters = letters.slice(0, i).concat(upperPartOfWord)
            else if startCaps == true
                letters = letters.join("").toUpperCase().split("")

        newWords.push(letters.join(""))

    return newWords.join(" ")

misspell.random = (min, max) ->
    return Math.floor(Math.random() * (max - min)) + min;