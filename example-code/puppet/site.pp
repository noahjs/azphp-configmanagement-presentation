
# /etc/puppet/manifests/site.pp

package { 'nginx': 
	ensure => installed
}
service { "nginx":
	ensure => "running", 
	require => Package["nginx"],
}
file { "/usr/share/nginx/www/index.html": 
	content => template("taste/index.erb"), 
	require => Package["nginx"],
}
if $hostname == "puppy" { 
	group { "puppy":
		name => "puppy",
		ensure => "present", 
	}
	user { "puppy":
		name => "puppy",
		groups => "puppy", 
		require => Group["puppy"],
	}
	file { "/usr/share/nginx/www/puppy.jpg":
		owner => "puppy",
		group => "puppy",
		mode => 664,
		source => "puppet:///modules/taste/puppy.jpg", 
		require => [ User["puppy"], Package["nginx"] ],
	}
}
if $hostname == "kitty" { 
	group { "kitty":
		name => "kitty",
		ensure => "present", 
	}
	user { "kitty":
		name => "kitty",
		groups => "kitty", 
		require => Group["kitty"],
	}
	file { "/usr/share/nginx/www/kitty.jpg":
		owner => "kitty",
		group => "kitty",
		mode => 664,
		source => "puppet:///modules/taste/kitty.jpg", 
		require => [ User["kitty"], Package["nginx"] ],
	}
}