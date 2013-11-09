##
# ConfigHelper
#
module ConfigHelper
  def self.included(base)
    base.extend ClassMethods
  end

  #------------------

  def config(options)
    @_config_reset = NPR.config
    NPR.config.merge(options)
  end

  #------------------

  def reset_config
    NPR.instance_variable_set(:@config, @_config_reset)
  end

  #------------------

  def config!(options)
    config = NPR::Configuration.new(options)
    NPR.instance_variable_set(:@config, config)
  end

  #------------------

  def clear_config
    NPR.instance_variable_set(:@config, nil)
  end

  #------------------

  module ClassMethods
    # Merge the options into whatever the config
    # currently is, and reset it to its previous
    # state after.
    def config(options)
      before :all do
        config(options)
      end

      after :all do
        reset_config
      end
    end

    #--------------------
    # Set the config to ONLY the provided options,
    # and set to nil after.
    def config!(options)
      before :all do
        config!(options)
      end

      after :all do
        reset_config
      end
    end
  end
end
