#!/usr/bin/env ruby

require './lib/version.rb'
require './lib/upload.rb'
require 'logger'

class TestSimundia

  # APP Menu

  puts "Welcome to the Simundia Test !!!"

  puts "1. Generate CSV from email file"
  puts "2. Quit"

  choice = gets.chomp

  case choice

  when "1"

    print "\n Enter file name : "
    file_path = gets.chomp

    upload_obj = Upload.new(file_path)
    upload_obj.import_data

  when "2"
    abort("Thank you.")
  end


end

