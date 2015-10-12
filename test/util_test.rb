require "test_helper"

class AuthorTest < Minitest::Test
  def test_git_remote_url
    remote = GitChange::Util.git_remote_url
    assert_equal "git@github.com:iamdionysus/git_change.git", remote
  end

  def test_user_email
    email = GitChange::Util.user_email
    # it's not 99.99% match though
    assert_match(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, email)
  end
end
