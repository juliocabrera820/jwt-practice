class RepositoriesRepository
  def all(user_id)
    Repository.where(user_id: user_id)
  end

  def show(user_id, id)
    Repository.where(user_id: user_id, id: id)
  end

  def create(user_id, repository_params)
    repository = Repository.new(repository_params)
    repository.user_id = user_id
    repository.save!
  end

  # TODO
  def delete(id)
    Repository.destroy(id)
  end

  def update(user_id, id, repository_params)
    repository = show(user_id, id)
    repository.update(repository_params)
  end
end
