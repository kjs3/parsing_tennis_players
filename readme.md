# Parsing Tennis Player Records and Printing

### What it does

* Reads included csv, psv (pipe separated), and ssv (space separated) txt files
* Automatically determines if file is csv, psv, or ssv
* Files represent groups of people and are split up into one person per line
* A record is parsed differently depending on file type
* All players are grouped into a people object
* Players are pretty-printed to the shell in various sortings

Everything is just straight Ruby/Core so you shouldn't need anything special.

Tested on OS X 10.8 with Ruby 2.0.0p0, 1.9.3p392, and 1.9.2p320

Tests are just Minitest so you don't need any spec/mocha gems.

### How to run

```
rake people
```

### Output

```
Output 1:
Hingis Martina Female 4/2/1979 Green
Kelly Sue Female 7/12/1959 Pink
Kournikova Anna Female 6/3/1975 Red
Seles Monica Female 12/2/1973 Black
Abercrombie Neil Male 2/13/1943 Tan
Bishop Timothy Male 4/23/1967 Yellow
Bonk Radek Male 6/3/1975 Green
Bouillon Francis Male 6/3/1975 Blue
Smith Steve Male 3/3/1985 Red

Output 2:
Abercrombie Neil Male 2/13/1943 Tan
Kelly Sue Female 7/12/1959 Pink
Bishop Timothy Male 4/23/1967 Yellow
Seles Monica Female 12/2/1973 Black
Bonk Radek Male 6/3/1975 Green
Bouillon Francis Male 6/3/1975 Blue
Kournikova Anna Female 6/3/1975 Red
Hingis Martina Female 4/2/1979 Green
Smith Steve Male 3/3/1985 Red

Output 3:
Smith Steve Male 3/3/1985 Red
Seles Monica Female 12/2/1973 Black
Kournikova Anna Female 6/3/1975 Red
Kelly Sue Female 7/12/1959 Pink
Hingis Martina Female 4/2/1979 Green
Bouillon Francis Male 6/3/1975 Blue
Bonk Radek Male 6/3/1975 Green
Bishop Timothy Male 4/23/1967 Yellow
Abercrombie Neil Male 2/13/1943 Tan
```

### Running Tests

```
rake test
```