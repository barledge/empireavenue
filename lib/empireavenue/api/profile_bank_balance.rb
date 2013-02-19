module EmpireAvenue
  module API
    module Profile
      def profile_bank_balance
	get("/profile/bank/balance")
      end
    end
  end
end