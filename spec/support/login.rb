module Sorcery
  module TestHelpers
    module Rails
      def login_user(user)
        page.driver.post(user_sessions_path, { email: user.email , password: 'secret' })
        user
      end
    end
  end
end
