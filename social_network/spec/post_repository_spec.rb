require 'post_repository'


def reset_social_network
  seed_sql = File.read('spec/seeds_socialnetwork.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end


describe PostRepository do
  before(:each) do 
    reset_social_network
  end

  it 'returns all posts' do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 3

    expect(posts[0].id).to eq '1'
    expect(posts[0].title).to eq 'Hello'
    expect(posts[0].content).to eq 'Coding is fun!'
    expect(posts[0].views).to eq '200'
    expect(posts[0].user_id).to eq '1'

    expect(posts[1].id).to eq '2'
    expect(posts[1].title).to eq 'Horses'
    expect(posts[1].content).to eq 'Horses are majestic.'
    expect(posts[1].views).to eq '1000'
    expect(posts[1].user_id).to eq '2'
  end 

  it 'gets a single post' do 

    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq '1'
    expect(post.title).to eq 'Hello'
    expect(post.content).to eq 'Coding is fun!'
    expect(post.views).to eq'200'
    expect(post.user_id).to eq'1'
  end

  it 'creates a new post' do 
    repo = PostRepository.new

    post = Post.new
    post.title = 'Dogs'
    post.content = 'Bichon, poodle, retreiver'
    post.views = '500'
    post.user_id = '1'

    repo.create(post)

    posts = repo.all 

    last_post = posts.last
    expect(last_post.title).to eq 'Dogs'
    expect(last_post.content).to eq 'Bichon, poodle, retreiver'
    expect(last_post.views).to eq '500'
    expect(last_post.user_id).to eq '1'
  end 

  it 'deletes a post' do 
    repo = PostRepository.new

    repo.delete(1)

    all_posts = repo.all 
    expect(all_posts.length).to eq 2
    expect(all_posts.first.id).to eq '2'
  end 
end 