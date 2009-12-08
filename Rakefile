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

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "time_travel"
    gemspec.summary = "A Rails plugin that makes it easy to write tests or specs for time-dependent code"
    gemspec.email = "pete@notahat.com"
    gemspec.homepage = "http://github.com/notahat/time_travel"
    gemspec.authors = ["Pete Yandell"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
