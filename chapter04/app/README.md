### New NodeRED packages

We will introduce three new packages; each one with a specific goal as explained below:

1. Measure the interval between messages using the package `node-red-contrib-interval-length`, described at https://flows.nodered.org/node/node-red-contrib-interval-length

2. Build a buffer with the incoming data over which we will perform statistical calculation, `node-red-contrib-buffer-array`, the description for which is found at https://flows.nodered.org/node/node-red-contrib-buffer-array

3. Carray out basic statistics over the array built in the buffer. The package is called `node-red-contrib-statistics` and its URL is https://flows.nodered.org/node/node-red-contrib-statistics

### Software architecture for the application

We do so to introduce a good practice that consists of organizing the flows in the order in which the data processing should occur. In this specific case, the order will be:
- Sense Hat tab: Acquire environment data and stream them to Pusher
- Global context tab: Save current conditions to NodeRED context
- Basic statistics tab: Subscribe to Pusher channel (event/topic env) and perform the statistical calculation to get insights from data in real time

### Basic statistics of environmental conditions

This will let us confront the two ways of approaching decision-making:
- Review data and make decisions based on a dashboard built using recorded data. With this approach, there will always be a delay between data acquisition and decision-making.
- Take decisions in real time, since the dashboard is depicted and instantly updated as new data comes in. This approach also open the possibilityto automate some decision processes that could be modelled with simple rule chains (i.e., conditions of the type if ... then ... else ...)

### Building the data processing code

The flows for this secion are arranged in three components, each linked to one of the three new packages:
1. Build a buffer with the incoming data to be processed downstream, functionality that is performed using the package `node-red-contrib-buffer-array`
2. Perform basic statistics over the array supplied by the buffer, i.e., calculation of mean and standard deviation. For such a purpose, we will use `node-red-contrib-statistics`.
3. Measure the interval between messages, for which we will need the package `node-red-contrib-interval-length`.

