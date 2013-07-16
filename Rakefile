require 'rake/testtask'
require './lib/people'

desc "Output People"
task :people do
  people = People.new(["comma.txt", "pipe.txt", "space.txt"])
  people.print() 
end

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.test_files = FileList['test/*_test.rb']
end