module Jobs
  #============================================================================
  # JobsBase
  # - configuration and logger
  # - perform options
  #============================================================================
  class JobBase
    attr_accessor :config,
                  :logger

    def initialize(config = {})
      init_config(config)
      init_logger
    end

    def perform(options = {})
      update_config(options)
    end

    #==========================================================================
    # Private scope
    #==========================================================================

    private

    #==========================================================================
    # Init and Configuration
    #==========================================================================
    def default_config
      cfg = Application.config
      self.class.name.split('::').map(&:underscore).each do |name|
        cfg = cfg[name.to_s] unless cfg.nil?
      end
      binding.pry
      cfg || {}
    end

    def init_config(options)
      @config = Utils.convert_hash_with_symbols_as_key(
        default_config.merge(options)
      )
    end

    def update_config(options)
      @config.merge!(Utils.convert_hash_with_symbols_as_key(options))
    end

    def init_logger
      @logger = Utils.create_logger(self.class.name)
    end
  end
end # module Jobs
