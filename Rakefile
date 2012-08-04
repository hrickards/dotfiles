# Runs default task from all Rakefiles in subdirs
task :default do
  FileList['*/Rakefile'].each do |file_name|
    Dir.chdir("#{ENV['HOME']}/dotfiles/#{file_name.pathmap('%d')}") {system 'rake'}
  end
end
