task :bootstrap => "bootstrap:config"

namespace :bootstrap do
  desc "Setup config files, based on examples"
  task :config => FileList["config/*.yml.example"].ext("")
end

rule ".yml" => ".yml.example" do |task|
  cp task.source, task.name
end
