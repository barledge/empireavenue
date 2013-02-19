module EmpireAvenue
  module API
    module Shares
      def shares_buy (ticker, shares, last_trade = nil)
	last_trade = profile_info(ticker)[:body][:data][0][:last_trade] unless last_trade
	params = {:ticker => ticker, :shares => shares, :last_trade => last_trade}
	post("/shares/buy", params)
      end
    end
  end
end
