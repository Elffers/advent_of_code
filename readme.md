# Advent of Code

[http://adventofcode.com](http://adventofcode.com)

Quick script for ease of retrieving input and creating ruby file:

Use:
$ aoc <day>

By default, retrieves input for current year for given <day>. If year is specified as second argument, will retrive for that year.

```
#!/bin/bash
YEAR="$(date +'%Y')"
if [ $2 ]; then
	YEAR=$2
fi

DAY=$1
if [ ${#DAY} -ge 1 ]; then DAY="0${DAY}"
fi

INPUT="${AOC_DIR}/$YEAR/inputs/day$DAY".in

curl "https://adventofcode.com/$YEAR/day/$1/input" -H "Cookie: session=${AOC_COOKIE}" -o $INPUT -s

FILE="${AOC_DIR}/$YEAR/day$DAY".rb

if [ -e $FILE ]; then
	echo "File $FILE already exists!"
else
	touch $FILE
	echo "input = File.readlines(\"$INPUT\")" >> $FILE
	echo "p input" >> $FILE
fi
```

