require 'user_repository'


def reset_social_network
  seed_sql = File.read('spec/seeds_socialnetwork.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do 
  before(:each) do 
    reset_social_network
  end

  it 'returns all users' do

    repo = UserRepository.new

    users = repo.all

    expect(users.length).to eq 3

    expect(users[0].id).to eq '1'
    expect(users[0].email_address).to eq 'angela@gmail.com'
    expect(users[0].username).to eq 'angela2'

    expect(users[1].id).to eq '2'
    expect(users[1].email_address).to eq 'john@gmail.com'
    expect(users[1].username).to eq 'john3'
  end 

  it 'returns a single user' do 
    repo = UserRepository.new

    user = repo.find(1)

    expect(user.id).to eq '1'
    expect(user.email_address).to eq 'angela@gmail.com'
    expect(user.username).to eq 'angela2'

  end 

  it 'creates a new user' do 
    repo = UserRepository.new

    user = User.new
    user.email_address = 'frances@gmail.com'
    user.username = 'frances5'

    repo.create(user) 

    users = repo.all 

    last_user = users.last
    expect(last_user.email_address).to eq 'frances@gmail.com'
    expect(last_user.username).to eq 'frances5'
  end 

  it 'deletes a user' do 
    repo = UserRepository.new

    repo.delete(1)

    all_users = repo.all 
    expect(all_users.length).to eq 2
    expect(all_users.first.id).to eq '2'
  end

end 