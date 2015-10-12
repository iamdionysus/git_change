require "git_change/util"
require "colorize"
require "thor"

module GitChange
  class Author < Thor::Group
    include Thor::Actions

    argument :name
    argument :email
    argument :old_name, optional: true, default: GitChange::Util.user_name
    argument :old_email, optional: true, default: GitChange::Util.user_email

    def self.source_root
      File.dirname(__FILE__)
    end

    def clone_repo_bare
      # get remote url for current repo
      remote_url = GitChange::Util.git_remote_url
      if remote_url.empty?
        puts "You need to have remote repository to work on".colorize(:red)
        return
      end
      if File.directory? "temp_repo"
        puts "temp_repo directory already exists".colorize(:red)
        return
      end
      # git clone bare to temp_repo to work on
      system "git clone --bare #{remote_url} temp_repo"
      puts "First step: clone the bare repository is done".colorize(:green)
    end

    def run_change_author_script
      # create script
      template "templates/change_author.tt", "temp_repo/change_author.sh"
      inside "temp_repo" do
        # run the script
        run "sh ./change_author.sh"
      end
    end

    def set_local_config
      # `git config user.name #{name}`
      # `git config user.email #{email}`
      puts "change local config user.name from #{old_name} to #{name}".
        colorize(:green)
      puts "change local config user.email from #{old_email} to #{email}".
        colorize(:green)
    end
  end
end
