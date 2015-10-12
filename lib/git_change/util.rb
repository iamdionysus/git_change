module GitChange
  class Util
    class << self
      def git_remote_url
        result = `git remote --verbose`
        remote = result.lines.first.split "\s"
        name = remote.shift
        url = remote.shift
        url
      end

      def user_name
        `git config user.name`.strip
      end
      
      def user_email
        `git config user.email`.strip
      end
    end
  end
end
