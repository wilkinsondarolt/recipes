module FixtureLoad
  def load_fixture(file_path)
    file_fixture(file_path).read
  end

  def json_file_fixture(file_path)
    JSON.parse(load_fixture(file_path), symbolize_names: true)
  end
end
