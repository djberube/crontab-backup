#!/usr/bin/env ruby

require 'fileutils'
backup_dir = 'crontab_backups'
FileUtils.mkdir backup_dir unless File.exist?(backup_dir)

hosts = ARGV

hosts.each do |h|
	username, host = * if h =~ /@/
		h.split('@')
	else
		['root', h	]
	end
		
	puts "backing up #{username}@#{host}..."	
	crontab = `ssh #{username}@#{host} 'crontab -l'`	
		
	filename = File.join(backup_dir, "#{username}_at_#{host}.crontab")	
	File.open(filename, 'w') do |fh| 
		fh.puts crontab
	end	
end
