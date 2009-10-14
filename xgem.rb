#!/usr/bin/env ruby
#
# PLEASE TAKE CARE, UNLESS YOU SURE YOU WANNA DO IT.
#
# @author xianhua.zhou@gmail.com
#
require 'rubygems'
require 'rubygems/commands/uninstall_command.rb'

gems = {}
dep = Gem::Dependency.new '', Gem::Requirement.default
Gem.source_index.search(dep).each do |index|
	name = index.name
	gems[name] = [] if gems[name].nil?
	gems[name] << index.version.to_s
end

gems.each do |name, versions|
	next if versions.size == 1
	versions.sort!.pop
	versions.each do |v|
		begin
			options = {:version => v}
			Gem::Uninstaller.new(name, options).uninstall
		rescue Exception => e
			puts "can't remove \"#{name} v#{v}\": #{e}"
		ensure
			next
		end
	end
end

puts "Clean!"
