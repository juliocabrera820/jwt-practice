class UsersRepository
  def all
    User.all
  end

  def show(id)
    User.find(id)
  end

  def create(user_params)
    user = User.new(user_params)
    user.save
  end

  def delete(id)
    User.destroy(id)
  end

  def update(id, user_params)
    user = show(id)
    user.update(user_params)
  end

  def find_by_email(email)
    User.find_by(email: email)
  end
end
