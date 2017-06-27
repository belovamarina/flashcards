desc 'This task is called by the Heroku and send notifies for users'

task send_notify: :environment do
  User.notify_about_pending_cards
end
