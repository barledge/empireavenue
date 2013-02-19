require 'json'

module EmpireAvenue
  module Rspec
    module API
      class Response
	
        @meta_vars = [:requested_user, :total_rows, :requested_page, :next_page, :prev_page, :total_pages, :uri, :limit, :limit_type, :requests, :reset, :recorded]
	  
	@meta_vars.each {|attr| attr_accessor attr}

	attr_accessor :data

	def self.meta_vars
	  @meta_vars
	end
	
        def initialize   
          @data = []
        end
	
        def to_json
	  hash.to_json
        end

	def meta_hash
	  hashify(self, self.class.meta_vars)
	end

	def data_hash
	  @data.collect { |obj| hashify(obj, obj.class.data_vars) }
	end
	
	def hash 
	  hash = {}
	  hash[:meta] = meta_hash unless meta_hash.empty?
	  hash[:data] = data_hash unless data_hash.empty?
	  hash
	end
		include
	protected
	
	def hashify (obj, set)
	  Hash[set.map do |name| 
	    value = obj.instance_variable_get("@#{name}")
	    [name, value] if value 
	  end]
	end
	  
	
      end
    
      module Data 


	def data_vars
	  @data_vars
	end

	def meta_vars
	  @meta_vars
	end

      end
 
      class ProfileInfoData  
	extend Data
	
	@data_vars = [:ticker, :first_name, :last_name, :full_name, :site_name, :site_url, :country, :location, :joined, :type, :max_shares, :commission, :last_trade, :outstanding_shares, :total_shares, :close, :close_money, :open, :yesterday_lowest, :yesterday_change, :yesterday_highest, :volume, :market_last_close, :market_last_open, :current_status, :current_status_set, :trading_status, :sm_portrait, :lg_portrait, :investments_count, :shareholders_count, :thumbs_up_count, :thumbs_down_count, :shares_owned_count, :listed_count, :recommended_count, :held_shares, :avg_div_per_share, :eav_score, :facebook_score, :flickr_score, :foursquare_score, :gplus_score, :instagram_score, :linkedin_score, :twitter_score, :youtube_score]

	@data_vars.each {|attr| attr_accessor attr}
	

      end
      
      class ProfileBankBalanceData
	extend Data

	@data_vars = [:balance]
		
	@data_vars.each {|attr| attr_accessor attr}
	
      end
      
      class SearchRecentData
	extend Data
	
	@data_vars = [:ticker, :full_name, :last_trade, :close, :sm_portrait, :lg_portrait, :location, :outstanding_shares, :country, :created, :max_shares, :eav_score, :facebook_score, :flickr_score, :foursquare_score, :gplus_score, :instagram_score, :linkedin_score, :twitter_score, :youtube_score]	  
	@data_vars.each {|attr| attr_accessor attr}
      end    
      
      class SharesBuyData
	extend Data
	
	@data_vars = [:success, :shares_owned, :commission, :total_charged, :bank_balance]
	
	@data_vars.each {|attr| attr_accessor attr}
      end
    end
  end
end