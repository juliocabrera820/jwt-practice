class RepositoryPresenter
  def initialize(repository)
    @repository = repository
  end

  def as_json
    {
      id: repository.id,
      name: repository.name,
      description: repository.description,
      visible: repository.visible
    }
  end

  private

  attr_reader :repository
end
