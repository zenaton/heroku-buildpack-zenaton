# heroku-buildpack-zenaton

The buildpack will install a Zenaton Agent inside your dynos, allowing your application to run tasks and workflows. You will also be able to use your dynos as Zenaton workers.

## Installation
To add the buildpack to your project, as well as the required environment variables, use the following commands:
```sh
cd <HEROKU_PROJECT_ROOT_FOLDER>

## If this is a new Heroku project
heroku create

# Add the appropriate language-specific buildpack
heroku buildpacks:add heroku/nodejs

# Add Zenaton buildpack and set your Zenaton credentials
heroku buildpacks:add --index 1 zenaton/heroku-buildpack-zenaton
heroku config:set ZENATON_APP_ID=<ZENATON_APP_ID>
heroku config:set ZENATON_API_TOKEN=<ZENATON_API_TOKEN>
heroku config:set ZENATON_APP_ENV=production

# Deploy to Heroku
git push heroku master
```

Replace <ZENATON_APP_ID> and <ZENATON_API_TOKEN> with your Zenaton credentials.

## Worker dynos
If you want to use some dynos to perform the execution of workflows and tasks, you have to configure a new dyno type in your Procfile which will start the Zenaton Agent, listen to an environment, and display logs in the output so you can easily view it:
```sh
# Procfile
web: node index.js
worker: zenaton start && zenaton listen --boot YOUR_BOOT_FILE && tail -f zenaton.*
```
Keeping the dyno alive

The tail command here also maintains the dyno alive. Because the worker is working in background, without the tail command Heroku will think the dyno crashed.
