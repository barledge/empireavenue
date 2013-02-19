module EmpireAvenue
  module API
    module Portfolio
      def portfolio_get (ticker = nil, page = nil, maxresults = nil)
	params = {}
	params = params.merge({:ticker => ticker}) if ticker
	params = params.merge({:page => page}) if page
	params = params.merge({:maxresults => maxresults}) if maxresults
	get("/portfolio/get", params)
      end
    end
  end
end
