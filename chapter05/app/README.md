### InfluxDB

```
influx -precision rfc3339
```

Then, create the `environment` dataset:
```
> CREATE DATABASE environment
```

Its contents are just two data points:
```
temperatures,location=HOME room="KITCHEN",instant=28.5,average=28.45 1597397160
temperatures,location=HOME room="KITCHEN",instant=28.4,average=28.42 1597397100
```

The first parameter in each line, `temperatures`, refers to the measurement.

It follows a set of the contextual features, named tags (`location` and `room` in our example), that are separated by spaces. If there are several, they constitue a tag set.

Finally - separated by colons - we have the fields. They contain values on a point and constitute a field set

**Note**: Fields store your data, while tags store the metadata, i.e., information that provides context to your data. As in SQL, tags are indexed columns that allow performing data searches. Finally, be aware that fields are treated as numeric values, while tags are processed as strings.

The last number in each is optional, and it refers to the timestamp:
- If you specify a value, it will correspond to UTC in seconds taking as reference 1 January 1970, i.e, UNIX time.
- If you do not write anything, InfluxDB will automatically insert the current timestamp.

You can import the file from a terminal using the `influx` command with the following options:
```
$ influx -import -path=temperature.txt -database=environment -precision=s
```
