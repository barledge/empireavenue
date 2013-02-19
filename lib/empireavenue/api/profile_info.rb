module EmpireAvenue
  module API
    module Profile
      def profile_info (ticker = nil)
	ticker = ticker.join(",") if ticker.is_a? Array 
	params = {:ticker => ticker} if ticker
	get("/profile/info", params)
      end
    end
  end
end
