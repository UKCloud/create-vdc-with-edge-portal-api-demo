# frozen_string_literal: true

module Portal
  # Represents a build within the Portal
  #
  # It is flexible enough to work with VDC builds and Edge Gateway builds.
  class Build
    def initialize(reload_proc, data)
      @reload_proc = reload_proc
      @data = data
    end

    attr_reader :reload_proc, :data

    def state
      data.attributes.state
    end

    def reload
      response = reload_proc.call(data.id.to_i)
      Build.new(reload_proc, response.data)
    end

    def done?
      succeeded? || failed?
    end

    def succeeded?
      state == 'completed'
    end

    def failed?
      state == 'failed'
    end
  end
end
