JSON to CSV converter
========

This project allows to convert a JSON file, which contains an array of objects, into a CSV file

## What can you do
This project is composed of a set of recursive functions `get_properties` and `get_values` that get an infinetely nested JSON objects (given they all have the same structure) and flatten them out.

Given the input 

```javascript
[{
    "email": "batman@justice_league.com",
    "tags": ["bat", "hero"],
    "profiles": {
        "facebook": {
            "id": 0,
            "picture": "Bruce.jpg"
        },
    }
}]
```

It will output the following

```
email, tags, profiles.facebook.id, profiles.facebook.picture
batman@justice_league.com, "bat,hero", 0, Bruce.jpg
```

## How to use
This project has a main function, `convert_json_to_csv` that takes 2 inputs:
    - input JSON file path
    - output CSV file path
And makes the full convertion and overwrites the given output file or creates a new one if the file path given doesn't exist.

The following command takes the example from `users.json` files and writes to `output.csv` file the result of the convertion

```
ruby main.rb
```