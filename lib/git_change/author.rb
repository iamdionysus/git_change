require "git_change/util"
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
      # inside it git clone bare
      system "git clone --bare #{remote_url} temp_repo"
    end

    def run_change_author_script
      # create script
      template "templates/change_author.tt", "temp_repo/change_author.sh"
      inside "temp_repo" do
        # run the script
        system "./change_author.sh"
      end
    end

    def set_local_config
      # run below
      # `git config user.name #{name}`
      # `git config user.email #{email}`
      puts "changed user.name from #{old_name} to #{name}"
      puts "changed user.email from #{old_email} to #{email}"
    end
  end
end
