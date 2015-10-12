require "thor"
require "git_change"

module GitChange
  class Runner < Thor
    include Thor::Actions

    desc "author <name> <email> [--old_email=old_email]",
      "Change author info in git log"
    method_option :old_email, aliases: "-e", type: :string,
      desc: "old email address to change"
    def author(name, email)
      puts options
      invoke GitChange::Author, [name, email], options
    end
  end
end
