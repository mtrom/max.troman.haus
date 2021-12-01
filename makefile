name=max.troman.haus
host=troman.haus

default: clean resume
	mkdir -p build/resume/
	cp index.html build/
	cp -r assets/ build/assets/
	cp -r latex/*.pdf build/resume/

local: default
	-rm -r /var/www/$(name)
	cp -r build /var/www/$(name)
	cp nginx/local.conf /usr/local/etc/nginx/$(name).conf
	nginx -s reload

deploy: default
	echo 'deploy'
	-ssh max@$(host) rm -r /var/max/$(name)/*
	scp -r build/* max@$(host):/var/www/$(name)/
	scp nginx/prod.conf max@$(host):/etc/nginx/sites-available/$(name).conf
	ssh max@$(host) ln -fs /etc/nginx/sites-available/$(name).conf /etc/nginx/sites-enabled/$(name).conf
	ssh root@$(host) nginx -s reload


resume:
	(cd latex; make)

clean:
	-rm -r build
