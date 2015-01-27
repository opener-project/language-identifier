desc 'Runs the tests'
task :test => :compile do
  sh 'rspec spec'
end
