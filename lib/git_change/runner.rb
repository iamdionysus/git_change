require "thor"
require "git_change"

module GitChange
  class Runner < Thor
    include Thor::Actions

    desc "author <name> <email>", "Change author info in git log"
    def author(name, email)
      invoke GitChange::Author, [name, email], options
    end
  end
end
