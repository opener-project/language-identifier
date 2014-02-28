Given /^the fixture file "(.*?)"$/ do |filename|
  @input = File.read(fixture_file(filename))
end

Then /^the output should match "(.*?)"$/ do |language|
  kernel.run(@input).should eql(language)
end

def fixture_file(filename)
  File.absolute_path("features/fixtures/", kernel_root) + "/#{filename}"
end
