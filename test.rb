#!/usr/bin/ruby

TAG_PATTERN = /^<.*>$/

to_match = '<li>item</li>'

if(TAG_PATTERN.match(to_match))
  puts('Matched!')
else
  puts('Not matched!')
end