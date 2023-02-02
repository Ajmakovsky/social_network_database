require 'user_repository'


def reset_social_network
  seed_sql = File.read('spec/seeds_socialnetork.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do 
  before(:each) do 
    reset_social_network
  end


end 