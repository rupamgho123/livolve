require 'padrino-core/cli/rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = FileList['test/lib/*.rb']
  t.test_files = FileList['test/*test.rb']
  t.verbose = true
end

PadrinoTasks.use(:activerecord)
PadrinoTasks.init
