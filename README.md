## Download Node 10.x from the official website
## Enabling the project feature

Now let's try the project function. We will use a standalone version of Node-RED on a local environment such as macOs or Windows. In order to use the project feature, we first need to enable it. Let's enable it by following these steps:

1. It is necessary to rewrite tthe `setttings.js` file to enable/disable the project function. Look for this file first. The `settings.js` file can be found in the Node-RED user directory where all of the user configurations are stored.

By default, on a Mac, this file is available under the following path:
```
/Users/<User Name>/.node-red/settings.js

```

By default, on Windows, this file is available under the following path:
```
C:\Users\<User Name>/.node-red/settings.js
```

2. Edit the `settings.js` file. It is OK to open `settings.js` with any text editors. I have used `vi` here. Open `settings.js` with the following command:
```
$ vi /Users/<User Name>/.node-red/settings.js
```

3. Edit your `settings.js` file and set the `projects.enabled` element to `true` in the `editorTheme` block within the `module.exports` block in order for the project feature to be enabled:
```
module.exports = {
    uiPort: process.env.PORT || 1880,
    ...
    editorTheme: {
        projects: {
            enabled: true
        }
    },
    ...
}
```

4. Save and close the `settings.js` file

5. Restart Node-RED to enable the settings we modified by running the following command:
```
$ node-red
```
