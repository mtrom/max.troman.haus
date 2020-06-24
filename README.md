## Setup
```
brew cask install basictex
sudo tlmgr install enumitem
```

## Deployment
```
// TODO
```

## Cheatsheet
Generate new `css` after changes to `styles.scss`:
```
sass --style=compressed --no-source-map assets/scss/styles.scss assets/css/styles.css
```
Reload after changes to `nginx.conf`:
```
nginx -s reload
```
Discover configuration file location and test it:
```
nginx -t
```

## Resources
- [NGINX Guide](http://nginx.org/en/docs/beginners_guide.html)
- [DigitalOcean Guide](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04)
