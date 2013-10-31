require 'rake/testtask'
require './lib/app'

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

namespace :seed_data do

  task :menu do
    LeCentral::Records.load_csv_menu
  end

end

# heroku run rake seed_data:menu
