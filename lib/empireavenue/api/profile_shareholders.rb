module EmpireAvenue
  module API
    module Profile
      def profile_shareholders (ticker = nil, page = nil, maxresults = nil)
	params = {}
	params = params.merge({:ticker => ticker}) if ticker
	params = params.merge({:page => page}) if page
	params = params.merge({:maxresults => maxresults}) if maxresults
	get("/profile/shareholders", params)
      end
    end
  end
end
