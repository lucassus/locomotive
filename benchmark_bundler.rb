#!/usr/bin/env ruby

# Script for benchmarking loading gems
# @see http://ablogaboutcode.com/2012/05/03/benchmark-your-bundle/
# @see https://gist.github.com/2654210

require 'bundler'
require 'benchmark'

REGEXPS = [
    /^no such file to load -- (.+)$/i,
    /^Missing \w+ (?:file\s*)?([^\s]+.rb)$/i,
    /^Missing API definition file in (.+)$/i,
    /^cannot load such file -- (.+)$/i,
]

def pull(dep)
  required_file = nil # Make sure var is still in scope in rescue block
  begin
    # Loop through all the specified autorequires for the
    # dependency. If there are none, use the dependency's name
    # as the autorequire.
    Array(dep.autorequire || dep.name).each do |file|
      required_file = file
      Kernel.require file
    end
  rescue LoadError => e
    if dep.autorequire.nil? && dep.name.include?('-')
      namespaced_file = nil # Make sure var is still in scope in rescue block
      begin
        namespaced_file = dep.name.gsub('-', '/')
        Kernel.require namespaced_file
      rescue LoadError
        REGEXPS.find { |r| r =~ e.message }
        raise if dep.autorequire || $1.gsub('-', '/') != namespaced_file
      end
    else
      REGEXPS.find { |r| r =~ e.message }
      raise if dep.autorequire || $1 != required_file
    end
  end
end

require 'rails/all'

$VERBOSE = nil

iterations = 10
report = {}
iterations.times do |i|
  puts "pass #{i + 1} of #{iterations}"
  input, output = IO.pipe
  pid = fork do
    input.close
    $stdout = output
    Benchmark.bm do |x|
      Bundler.setup.dependencies.each do |dependency|
        x.report(dependency.name) do
          pull(dependency)
        end
      end
    end
    output.close
    exit!
  end
  output.close
  Process.wait(pid)

  lines = input.read.chomp.split(/$/)
  lines.shift
  lines.each do |line|
    name, user, system, total, real = line.gsub(/[()]/, '').chomp.split
    info = report[name] || {:user => 0.0, :system => 0.0, :total => 0.0, :real => 0.0}
    info[:user] += user.to_f
    info[:system] += system.to_f
    info[:total] += total.to_f
    info[:real] += real.to_f
    report[name] = info
  end
end

sum_user = 0.0
sum_system = 0.0
sum_total = 0.0
sum_real = 0.0
report.values.each do |info|
  sum_user += info[:user] / iterations
  sum_system += info[:system] / iterations
  sum_total += info[:total] / iterations
  sum_real += info[:real] / iterations
end

padding = report.keys.collect(&:size).max
puts "#{'gem'.ljust(padding)} #{'user'.ljust(8)} #{'system'.ljust(8)} #{'total'.ljust(8)} #{'real'.ljust(8)}"
puts('-' * (padding + 36))
report.to_a.sort{|a,b| b.last[:real] <=> a.last[:real]}.each do |name, info|
  puts "#{name.ljust(padding)} #{sprintf('%0.6f', info[:user] / iterations)} #{sprintf('%0.6f', info[:system] / iterations)} #{sprintf('%0.6f', info[:total] / iterations)} #{sprintf('%0.6f', info[:real] / iterations)}"
end
puts('-' * (padding + 36))
puts "#{'TOTAL'.ljust(padding)} #{sprintf('%0.6f', sum_user)} #{sprintf('%0.6f', sum_system)} #{sprintf('%0.6f', sum_total)} #{sprintf('%0.6f', sum_real)}"
