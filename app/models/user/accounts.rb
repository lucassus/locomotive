class User
  module Accounts

    # Check if the user is connected to facebook account
    def connected_to_facebook?
      connected_to?(UserAccount::FACEBOOK)
    end

    def facebook_account
      accounts.find_by_provider(UserAccount::FACEBOOK)
    end

    # Check if the user is connected to twitter account
    def connected_to_twitter?
      connected_to?(UserAccount::TWITTER)
    end

    def twitter_account
      accounts.find_by_provider(UserAccount::TWITTER)
    end

    def connected_to_google?
      connected_to?(UserAccount::GOOGLE)
    end

    def google_account
      accounts.find_by_provider(UserAccount::GOOGLE)
    end

    # Check if the user is connected to the given account
    def connected_to?(provider)
      accounts.exists?(:provider => provider.to_s)
    end

    def connect_to!(provider, options)
      raise if connected_to?(provider)

      attributes = options.merge(:provider =>  provider.to_s)
      accounts.create!(attributes)
    end
  end
end
