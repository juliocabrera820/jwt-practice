class RepositoriesPresenter
  def initialize(repositories)
    @repositories = repositories
  end

  def as_json
    repositories.map do |repository|
      {
        id: repository.id,
        name: repository.name,
        description: repository.description,
        visible: repository.visible
      }
    end
  end

  private

  attr_reader :repositories
end
