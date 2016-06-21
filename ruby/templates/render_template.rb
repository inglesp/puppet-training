require "erb"
require "json"

class Namespace
  def initialize(hash)
    hash.each do |key, value|
      instance_variable_set(:"@#{key}", value)
    end 
  end

  def get_binding
    binding
  end
end

def exit_with_error(msg = nil)
  if msg
    puts msg
    puts
  end
  puts "Usage: ruby render_template.rb path/to/template.erb path/to/data.json"
  exit 1
end

if ARGV.size != 2
  exit_with_error
end

template_path, data_path = ARGV

begin
  template = File.read(template_path)
rescue Errno::ENOENT
  exit_with_error("Could not read template file at #{template_path}")
end

parsed_template = ERB.new(template)

begin
  data = File.read(data_path)
rescue Errno::ENOENT
  exit_with_error("Could not read data file at #{data_path}")
end

begin
  parsed_data = JSON.parse(data)
rescue JSON::ParserError
  exit_with_error("Could not parse data file at #{data_path}")
end

namespace = Namespace.new(parsed_data)
parsed_template = ERB.new(template, nil, '-')

begin
  output = parsed_template.result(namespace.get_binding)
rescue Exception => e
  puts "#{e.backtrace[0]}: #{e.message} (#{e.class})"
  exit 1
end

puts output
