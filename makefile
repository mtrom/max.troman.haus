name=max.troman.haus
host=troman.haus

default: clean resume
	mkdir -p build/resume/
	mkdir -p build/assets/css/
	cp index.html build/
	cp -r assets/images/ build/assets/images/
	cp -r latex/resume.pdf build/resume/
	sass --style=compressed --no-source-map assets/scss/styles.scss build/assets/css/styles.css

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

# build resume pdf
resume:
	(cd latex; make)

clean:
	-rm -r build
