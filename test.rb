#!/usr/bin/ruby

hostname = 'alexpolson.org'

pattern = Regexp.new('alexpolson.(mobi|org|com|info|net)')
if(pattern.match(hostname))
  puts('Matched!')
else
  puts('Not matched!')
end