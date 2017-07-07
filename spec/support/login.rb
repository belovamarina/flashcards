module Sorcery
  module TestHelpers
    module Rails
      def login_user(user)
        visit login_path

        within(:xpath, "//form") do
          fill_in '_email', with: user.email
          fill_in '_password', with: 'secret'
          page.first(:xpath, "input[@type='submit']").click
        end
        user
      end
    end
  end
end
