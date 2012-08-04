# Based upon holman's dotfiles
require 'colorize'

# Returns whether the two files are the same, handling errors
def files_are_same(file1, file2)
  begin
    File.open(file1, 'rb').read == File.open(file1, 'rb').read
  rescue
    false
  end
end

# file_name should be in the dotfiles directory - e.g. 'bash/bashrc'
# destination_name should be a path in ~/ - e.g. '.bashrc'
def elegant_move(file_name, destination_name)
  # Generate full paths
  destination = "#{ENV['HOME']}/#{destination_name}"
  file = "#{ENV['HOME']}/dotfiles/#{file_name}"

  # If the destination already exists
  if (File.exists?(destination) or File.symlink?(destination))
    # If the destination has the same content as the file, skip
    if files_are_same(destination, file)
      puts "#{file_name} - skipping".yellow
    else
      # Create the backup dir if doesn't already exist
      `mkdir -p ~/.backup`

      # Else backup the old file
      backup_path = ".backup/#{destination_name}_#{Time.now.to_f}"
      backup = "#{ENV['HOME']}/#{backup_path}"
      puts "#{file_name} - moving old".green
      # Ignore errors we may get in case of dodgy symlinks
      `mv #{destination} #{backup} 2> /dev/null`
      
      # Then link the new file
      symlink file, destination, :force => true, :verbose => false
    end
  else
    # Else link the new file
    puts "#{file_name} - creating".green
    symlink file, destination, :force => true, :verbose => false
  end
end
