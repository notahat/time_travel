require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'

desc "Default: run specs"
task :default => :spec

desc "Run all the specs for the time_travel plugin."
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--colour']
  t.rcov = true
  t.rcov_opts = ["--exclude \"spec/*,gems/*\""]
end
