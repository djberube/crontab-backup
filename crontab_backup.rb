require 'thor'
require 'fileutils'
require 'tty-command'

class CrontabBackup < Thor
  # Define the 'backup' command with an optional list of hosts
  desc "backup [HOSTS]", "Backup crontabs for specified hosts"

  # Define the 'backup_dir' option with a default value and description
  option :backup_dir, default: './crontab_backups', desc: "Directory for storing crontab backups"

  def backup(*hosts)
    # Expand the backup directory path
    backup_dir = File.expand_path(options[:backup_dir])

    # Create the backup directory if it doesn't exist
    FileUtils.mkdir backup_dir unless File.exist?(backup_dir)

    hosts.each do |h|
      # If the host includes a username (e.g., user@host), split it
      if h =~ /@/
        username, host = h.split('@')
      else
        # If no username is provided, use the current user
        username = `whoami`
        host = h
      end

      puts "backing up #{username}@#{host}..."

      # Retrieve the crontab contents via SSH
      crontab = `ssh #{username}@#{host} 'crontab -l'`

      # Generate the backup filename
      filename = File.join(backup_dir, "#{username}_at_#{host}.crontab")

      # Write the crontab contents to the backup file
      File.open(filename, 'w') do |fh|
        fh.puts crontab
      end

      # Create a TTY::Command instance for running Git commands
      cmd = TTY::Command.new

      # Get the current date in the format "mm/dd/yy"
      date = Time.now.strftime("%m/%d/%y")

      # Change to the backup directory
      Dir.chdir backup_dir do
        # Initialize a Git repository if it doesn't exist
        cmd.run("git init")

        # Stage all changes
        cmd.run("git add .")

        # Commit the changes with a message including the date
        cmd.run("git commit -am 'Crontab backup #{date}'")
      end
    end
  end
end

# Start the Thor CLI with the provided arguments
CrontabBackup.start(ARGV || ENV['CRONTAB_BACKUP_HOSTS']&.split(','))
