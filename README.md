Jekyll Docker
-------------
`Jekyll Docker` is a simple source to build [Docker](https://docker.com/) image for Jekyll project management. It use [Bundler](https://bundler.io/) inside as a base tool to control Jekyll and its dependencies. Built image includes only Bundler and system libraries for native extensions. Jekyll and all related gems located on a host machine project folder. Image based on ruby:alpine image.

Installation
------------
```sh
git clone https://github.com/caxapyk/jekyll-docker
cd jekyll-docker
docker build --rm --no-cache -t jekyll .
```

Scripts
-------
`Jekyll Docker` has bin folder with shell scripts to automate some actions. You can call them by following construction:
```sh
docker run --rm \
	--volume="$PWD:/srv/jekyll" \
	--volume="$PWD/vendor/bundle:/usr/local/bundle" \
	-it jekyll <script-name>
```

There are ready to use scripts:
- `build` - alias to build Jekyll site
- `new` - create a new Jekyll project
- `serve` - alias to run server for Jekyll project at address [http://localhost:4000](http://localhost:4000).
You can add your own scripts there and then rebuild image.

Create a new site
---------------
As mentioned above `Jekyll Docker` uses Bundler to manage Jekyll projects. We can create a new site manually or by using pre-installed script.
```sh
docker run --rm \
	--volume="$PWD:/srv/jekyll" \
	--volume="$PWD/vendor/bundle:/usr/local/bundle" \
	-it jekyll new
```

Read [Jekyll docs](https://jekyllrb.com/tutorials/using-jekyll-with-bundler/) if you want to install it manually.

Serve site
----------
To start Jekyll built-in web server just run (use `-d` flag to run as daemon):
```sh
docker-compose up
```
or run Docker command with alias:
```sh
docker run --rm \
	--volume="$PWD:/srv/jekyll" \
	--volume="$PWD/vendor/bundle:/usr/local/bundle" \
	-p 4000:4000 \
	-it jekyll serve
```

Jekyll site will be able on host machine at address [http://localhost:4000](http://localhost:4000).

Build project
-------------
The shortest way to build Jekyll site is using alias:
```sh
docker run --rm \
	--volume="$PWD:/srv/jekyll" \
	--volume="$PWD/vendor/bundle:/usr/local/bundle" \
	-it jekyll build
```

Update Jekyll
-------------
Use [Bundler](https://bundler.io/) to manage Jekyll and its dependencies. To update all packages to the latest version use command:
```sh
docker run --rm \
	--volume="$PWD:/srv/jekyll" \
	--volume="$PWD/vendor/bundle:/usr/local/bundle" \
	-it jekyll bundle update
```

Docker Compose
--------------
Common way to use docker-compose:
```sh
docker-compose run jekyll <command>
```

Issues
------
Before first build you should add exludes to `_config.yml` to avoid errors:
```yaml
exclude:
   - vendor/bundle/
   - vendor/cache/
   - vendor/gems/
   - vendor/ruby/
```