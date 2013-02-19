
module EmpireAvenue
  module API
    module Profile
      def profile_info (ticker = nil)
	get("/profile/info?ticker=#{ticker}")
      end
    end
  end
end
