module EmpireAvenue
  module API
    module Search
      def search_recent
	get("/search/recent")
      end
    end
  end
end