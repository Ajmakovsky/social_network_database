require 'post'

class PostRepository
  def all
    # Executes the SQL query:
    sql = 'SELECT id, title, content, views, user_id FROM posts;'

    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.user_id = record['user_id']

      posts << post
    end 

    return posts

    # Returns an array of Post objects.
  end

  def find(id)
    sql = 'SELECT id, title, content, views, user_id FROM posts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.views = record['views']
    post.user_id = record['user_id']

    return post
  end

  def create(post)
    # executes the SQL query: 
    sql = 'INSERT INTO posts (title, content, views, user_id) VALUES($1, $2, $3, $4);'
    sql_params = [post.title, post.content, post.views, post.user_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil

    #returns nothing 
  end

  def delete(id)
    # executes the SQL query: 
    sql = 'DELETE FROM posts WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil

    #returns nothing (only deletes the user record)
  end

end 