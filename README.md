# Angular with Docker

Creating angular 17 project without installing anything in host machine with the help of docker.

## Creating new project

```shell
docker-compose run --rm ng new --directory ./ --skip-install
```

* Give your desired name for the project when prompted
* Abort (CTR + C) if node package is getting installed

* If `node_modules` folder was created, the error like the below screenshot will be thrown when trying to run `ng serve`. So delete it, if it got created.

![image](https://github.com/actionanand/laravel_with_docker/assets/46064269/7510a83c-cafb-4b17-9e3d-179d704f2831)

* Command to delete node_modules in Linux and wsl

```bash
rm -rf angular/node_modules
```

* Command to delete node_modules in powershell

```powershell
Remove-Item angular/node_modules -Recurse -Force
```

* Command to delete node_modules in command prompt

```cmd
rmdir angular\node_modules
```

### Modifying package.json file

* Add `"ng-start": "ng serve --host 0.0.0.0",` to `script` property in `package.json` file

![image](https://github.com/actionanand/laravel_with_docker/assets/46064269/f3a14469-b781-48ec-ba7f-89891211c351)

### Running dev server

1. Spin-up the `vite` server

```bash
docker-compose up -d --build server
```

`-d` to run in detached mode.

2. Copy the `package-lock.json` to host machine

    * Check running conatiner by `docker ps` and consider this last container name is `angular_with_docker_server_1`

```bash
docker cp angular_with_docker_server_1:/app/package-lock.json angular
```

3. Point your browser to `http://localhost:4201/`

4. After finished working,

```bash
docker-compose down
```

to remove named volumes while removing container,

```bash
docker-compose down -v
```

### Generating new component, service, etc using 'ng' command

```bash
docker-compose run --rm ng g c pages/home
```

### Installing packages with 'ng add'

* we can see example with `ng add @angular/pwa`. Other packages also uses the same way to be added!

```bash
docker-compose run --rm ng add @angular/pwa
```

### Installing some third party npm packages

1. Run `npm install` as below always

```bash
docker-compose run --rm npm install
```

2. Installing `lodash` follows below:

```bash
docker-compose run --rm npm install --save lodash
```

```bash
docker-compose run --rm npm install --save-dev @types/lodash
```

Remove `node_modules` after finishing it all.

![image](https://github.com/actionanand/laravel_with_docker/assets/46064269/f0d40549-7809-487e-b64e-e645441174ec)

![image](https://github.com/actionanand/laravel_with_docker/assets/46064269/555411d5-86de-42b5-88c3-a078adc192cf)

* [How to import lodash in angular](https://stackoverflow.com/questions/41991178/correct-way-of-importing-and-using-lodash-in-angular/59908442#59908442)


### Testing Angular app

```bash
docker-compose up --build test
```

* Point your browser to `http://localhost:4203/`

* Remove the container

```bash
docker-compose down
```

### Running Angular app in SSR mode

1. Building angular files

```bash
docker-compose run --rm build run build
```

2. Running express server

```bash
docker-compose run --rm build run serve:ssr:my_angular_play
```

* You can try any `script` in `package.json` after `npm` with `docker-compose run --rm build run`

## Preparing to push to docker hub

* Navigate to the folder where `angular.dockerfile` exists, then execute the below command

1. Building the image for Angular 17

```bash
docker build . -t actionanand/ng-create:17 -f angular.dockerfile
```

2. Pushing the Image

```shell
docker push actionanand/ng-create:17
```

## Utilizing docker hub Image

* Pull Angular 17

```bash
docker pull actionanand/ng-create:17
```

* Creating new angular project

```shell
docker run --rm -it --name ng-create -v "folder_path:/app" actionanand/ng-create:17 new
```

In mac, linux or wsl2

```shell
docker run --rm -it --name ng-create -v $(pwd):/app actionanand/ng-create:17 new 
```

In windows,

```bash
docker run --rm -it --name ng-create -v "D:\AR_extra\rnd\docker\test:/app" actionanand/ng-create:17 new
```

* creating new Angular project in the current folder

```bash
docker run --rm -it --name ng-create -v $(pwd):/app actionanand/ng-create:17 new --directory .
```

### Generating new component, service, etc

* Creating `home` component under the folder `pages`
```bash
docker run --rm -it --name ng-create -v $(pwd):/app actionanand/ng-create:17 g c pages/home
```

### Installing packages with 'ng add'

* we can see example with `ng add @angular/pwa`. Other packages also uses the same way to be added!

```bash
docker run --rm -it --name ng-create -v $(pwd):/app actionanand/ng-create:17 add @angular/pwa
```

### Some useful commands

1. `docker container prune` - to remove all stopped containers
2. `docker system prune` - to remove all stopped images. This command will remove all stopped containers, networks, and dangling images
3. If you want to remove all images, not just the dangling ones, you can add the '-a' option to the command, like so:

```bash
docker system prune -a
```
4. `docker volume prune` -  to remove unused volumes

## Docker Image for creating angular project

* [actionanand/ng-create](https://hub.docker.com/r/actionanand/ng-create)

## Associated repos:

1. [Docker Basics](https://github.com/actionanand/docker_playground)
2. [Managing Data and working with volumes](https://github.com/actionanand/docker_data_volume)
3. [Docker Communication](https://github.com/actionanand/docker_communication)
4. [Docker Multi-container with docker-compose](https://github.com/actionanand/docker_multi-container)
5. [Docker Utility Containers & Executing Commands](https://github.com/actionanand/node-util)
6. [Laravel with Docker](https://github.com/actionanand/laravel_with_docker)
7. [Angular with Docker](https://github.com/actionanand/angular_with_docker)
