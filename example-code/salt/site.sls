nginx: 
	pkg:
		- installed 
	service:
		- running
		- enable: True
		- require:
			- pkg: nginx
/usr/share/nginx/www/index.html: 
	file:
		- managed
		- source: salt://index.html
		- template: jinja
		- require:
			- pkg: nginx
{% if grains['host'] == 'puppy' %} puppy:
user:
	- present
	- groups:
		- puppy
	- require:
		- group: puppy 
group:
	- present

/usr/share/nginx/www/puppy.jpg: 
	file:
		- managed
		- source: https://raw.github.com/nanobeep/tt/master/puppy.jpg 
		- source_hash: md5=8f3a3661eb7b34036781dac5b6cd9d32
		- user: puppy
		- group: puppy
		- mode: 664
	require:
		- pkg: nginx
		- user: puppy 
		- group: puppy
{% endif %}

{% if grains['host'] == 'kitty' %} 
kitty:
	user:
		- present
		- groups:
			- kitty
		- require:
			- group: kitty 
	group:
		- present
/usr/share/nginx/www/kitty.jpg: 
	file:
		- managed
		- source: https://raw.github.com/nanobeep/tt/master/kitty.jpg 
		- source_hash: md5=f39b24938f200e59ac9cb823fb71cad4
		- user: kitty
		- group: kitty
		- mode: 664
	require:
		- pkg: nginx
		- user: kitty 
		- group: kitty
{% endif %}