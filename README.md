# API Tools packed in Docker container

Container containing different tools for Contract/API First approach.
Mounting you current filesystem folder into container workspace.

## How to start

Create alias on your machine:
```
alias apit="docker run --rm -it -v $(pwd):/opt/workspace dsauer/api-tooling:latest"
```

Navigate in your local folder where you want to work with API files, and execute your alias `apit`.
After which you folder will be mounded into Docker volume in `workspace` folder.

## Available commands 


- `api` main command for working with you APIs
  Use `api help` to list all available commans.

Other useful tools available in the container
- `curl`, `jq`, `mtr`, `httpie`, `git`, `zsh`, `vim`, `npm`


## TODO
- add openjdk, maven
- implement `api` predefined commands
  - add OpenAPI project template

## Local development

- `make local-build` build latest image locally
- `make local-dev` will enter the container and mount `template` and `tooling` folders, 
   so they can be edited on your machine, not in the container.
   This is handy when creating and testing new `api` commands. 
- `make apit` Start API tool container in `out` folder as Workspace.

   