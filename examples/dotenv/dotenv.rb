require 'dotenv'
Dotenv.load(
  File.join(File.dirname(File.expand_path(__FILE__)), '.env')
)
puts ENV["ENVVALUE"]