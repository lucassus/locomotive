class User
  module Accounts

    [:facebook, :twitter, :google].each do |provider|
      define_method :"connected_to_#{provider}?" do
        connected_to?(provider)
      end

      define_method :"#{provider}_account" do
        accounts.find_by_provider(provider)
      end
    end

    # Check if the user is connected to the given account
    def connected_to?(provider)
      accounts.exists?(:provider => provider.to_s)
    end

    # Connect the user with given account
    def connect_to!(provider, options)
      raise if connected_to?(provider)

      attributes = options.merge(:provider =>  provider.to_s)
      accounts.create!(attributes)
    end
  end
end
