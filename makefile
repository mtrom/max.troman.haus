name=max.troman.haus
host=67.205.176.83

default: clean resume
	mkdir -p build/resume/
	cp index.html build/
	cp -r assets/ build/assets/
	cp -r latex/*.pdf build/resume/

local: default
	-rm -r /var/www/$(name)
	cp -r build /var/www/$(name)
	cp nginx.conf /usr/local/etc/nginx/max.troman.haus.conf
	nginx -s reload

deploy: default
	-ssh max@$(host) rm -r /var/max/max.troman.haus/*
	scp -r build/* max@$(host):/var/www/max.troman.haus/
	scp nginx.conf max@$(host):/etc/nginx/sites-available/max.troman.haus.conf
	ssh max@$(host) ln -s /etc/nginx/sites-available/max.troman.haus.conf /etc/nginx/sites-enabled/max.troman.haus.conf
	ssh root@$(host) nginx -s reload


resume:
	(cd latex; make)

clean:
	-rm -r build
