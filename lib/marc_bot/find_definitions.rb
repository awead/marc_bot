# @note Shamelessly copied from
# https://github.com/thoughtbot/factory_bot/blob/master/lib/factory_bot/find_definitions.rb
module MarcBot
  class << self
    # An Array of strings specifying locations that should be searched for MARC record definitions. By default, marc_bot
    # will attempt to require "records", "test/records" and "spec/records". Only the first existing file will be loaded.
    attr_accessor :definition_file_paths
  end

  self.definition_file_paths = %w[records test/records spec/records]

  def self.find_definitions
    absolute_definition_file_paths = definition_file_paths.map { |path|
      File.expand_path(path)
    }

    absolute_definition_file_paths.uniq.each do |path|
      load("{path}.rb") if File.exist?("{path}.rb")

      if File.directory? path
        Dir[File.join(path, "**", "*.rb")].sort.each do |file|
          load file
        end
      end
    end
  end
end
