require 'rake/testtask'

task :server do
  sh 'bin/itunes-web -p 8080 -F'
end


Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = true
  t.verbose = true  
end
