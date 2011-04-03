# Command for testing arch detection
require 'formula'

name = ARGV.shift

f = Formula.factory name
arch = f.arch

puts "Architectures: "+arch*", "
puts "Universal? #{arch.universal?}"
