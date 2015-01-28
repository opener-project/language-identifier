module FixtureHelpers
  ##
  # @return [Array]
  #
  def language_directories
    return Dir.glob(fixture_path('languages/*')).select { |d| File.directory?(d) }
  end

  ##
  # @param [String] path
  #
  def language_files(path)
    return Dir.glob(File.join(path, '*.txt'))
  end

  ##
  # @param [String] path
  # @return [String]
  #
  def fixture(path)
    return File.read(fixture_path(path))
  end

  ##
  # @param [String] path
  # @return [String]
  #
  def fixture_path(path)
    fixture_path = File.expand_path('../../fixtures', __FILE__)

    return File.join(fixture_path, path)
  end
end # FixtureHelpers
