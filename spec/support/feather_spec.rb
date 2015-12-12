include Warden::Test::Helpers

module LoginHelpers
  def login(user)
    login_as user, scope: :user
  end
end
