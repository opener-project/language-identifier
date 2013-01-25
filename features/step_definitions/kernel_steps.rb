Given /^an argument as language coverage "(\d)"$/ do |language_coverage|
  $language_coverage = language_coverage.to_i
end

Given /^the fixture file "(.*?)"$/ do |filename|
  @input = fixture_file(filename)
  @filename = filename
end

Given /^I put them through the kernel$/ do
  @tmp_filename = "output_#{rand(1000)}_#{@filename}"
  @output = tmp_file(@tmp_filename)
  lib_dir()
  `perl -I #{$LIB_DIR} #{KERNEL_CORE} #{$language_coverage} #{@input} > #{@output}`
end

Then /^the output should match the fixture "(.*?)"$/ do |filename|
  fixture_output = File.read(fixture_file(filename))
  output = File.read(@output)
  output.should eql(fixture_output)
end

def fixture_file(filename)
  File.expand_path("../../../features/fixtures/#{filename}", __FILE__)
end

def tmp_file(filename)
  File.expand_path("../../../tmp/#{filename}", __FILE__)
end

def lib_dir()
  $LIB_DIR = File.expand_path("../../lib/", File.dirname(__FILE__))
end

