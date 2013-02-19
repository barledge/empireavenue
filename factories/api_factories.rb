require './spec/factory_classes'

FactoryGirl.define do
  
  factory :response, class: EmpireAvenue::Rspec::API::Response do
  
    total_rows {data.count}
    limit "150"
    limit_type "user"
    requests 1
    reset 3600
    recorded {Time.now}
  
  end
  
  factory :profile_info_data, class: EmpireAvenue::Rspec::API::ProfileInfoData do
    
    ticker "AVIDBEAVER" 
    first_name "Avid" 
    last_name "Beaver" 
    full_name "Avid Beaver" 
    site_name "" 
    site_url "" 
    country "World" 
    location "Island" 
    joined "2012-12-12 12:12:12" 
    type "person" 
    max_shares 1400 
    commission "5.00" 
    last_trade "168.34393" 
    outstanding_shares "349086" 
    total_shares "360000" 
    close "164.83158" 
    close_money "394954.58956" 
    open "165.52774" 
    yesterday_lowest "158.27974" 
    yesterday_change "6.14439" 
    yesterday_highest "164.83158" 
    volume "21155" 
    market_last_close "2013-02-16 11:57:42" 
    market_last_open "2013-02-16 11:58:06" 
    current_status "Status text" 
    current_status_set "2013-02-11 19:17:33" 
    trading_status "enabled" 
    sm_portrait "https://s3.amazonaws.com/empireavenue-public/portraits/p_sm_AVIDBEAVER_7b1b50ba737e.jpg" 
    lg_portrait "https://s3.amazonaws.com/empireavenue-public/portraits/p_lg_AVIDBEAVER_7b1b50ba737e.jpg" 
    investments_count "976" 
    shareholders_count "732" 
    thumbs_up_count "0" 
    thumbs_down_count "0" 
    shares_owned_count "218949" 
    listed_count "40" 
    recommended_count "18" 
    held_shares 201 
    avg_div_per_share "1.20" 
    eav_score "39.128" 
    facebook_score "43.730" 
    flickr_score "5.631" 
    foursquare_score "20.968" 
    gplus_score "1.000" 
    instagram_score "23.266" 
    linkedin_score "29.677" 
    twitter_score "40.820" 
    youtube_score "1.324"
    
  end

  factory :profile_bank_balance_data, class: EmpireAvenue::Rspec::API::ProfileBankBalanceData do
    balance "890111234.12345"
  end 

  factory :profile_shareholders_data, class: EmpireAvenue::Rspec::API::ProfileShareholdersData do
    
    ticker "AVIDBEAVER" 
    full_name "Avid Beaver" 
    last_trade "168.34393" 
    close "164.83158"
    yesterday_lowest "158.27974" 
    yesterday_highest "164.83158" 
    sm_portrait "https://s3.amazonaws.com/empireavenue-public/portraits/p_sm_AVIDBEAVER_7b1b50ba737e.jpg" 
    lg_portrait "https://s3.amazonaws.com/empireavenue-public/portraits/p_lg_AVIDBEAVER_7b1b50ba737e.jpg" 
    location "Island" 
    outstanding_shares "349086" 
    country "World" 
    portfolio_value "8769871.18754"
    yesterday_earnings "1234.56789"
    eav_score "39.128" 
    facebook_score "43.730" 
    flickr_score "5.631" 
    foursquare_score "20.968" 
    gplus_score "1.000" 
    instagram_score "23.266" 
    linkedin_score "29.677" 
    twitter_score "40.820" 
    youtube_score "1.324"
    shares "124"
    last_buy_shares "24" 
    last_buy "2013-02-16 11:57:42"
    your_shares_held "200"
    max_shares 1400     
  end

  factory :portfolio_get_data, class: EmpireAvenue::Rspec::API::PortfolioGetData do
    
    ticker "AVIDBEAVER" 
    full_name "Avid Beaver" 
    last_trade "168.34393" 
    close "164.83158"
    yesterday_lowest "158.27974" 
    yesterday_highest "164.83158" 
    sm_portrait "https://s3.amazonaws.com/empireavenue-public/portraits/p_sm_AVIDBEAVER_7b1b50ba737e.jpg" 
    lg_portrait "https://s3.amazonaws.com/empireavenue-public/portraits/p_lg_AVIDBEAVER_7b1b50ba737e.jpg" 
    location "Island" 
    outstanding_shares "349086" 
    country "World" 
    portfolio_value "8769871.18754"
    yesterday_earnings "1234.56789"
    eav_score "39.128" 
    facebook_score "43.730" 
    flickr_score "5.631" 
    foursquare_score "20.968" 
    gplus_score "1.000" 
    instagram_score "23.266" 
    linkedin_score "29.677" 
    twitter_score "40.820" 
    youtube_score "1.324"
    shares "124"
    last_buy_shares "24" 
    last_buy "2013-02-16 11:57:42"
    your_shares_held "200"
    max_shares 1400 
  end

  factory :portfolio_base_data, class: EmpireAvenue::Rspec::API::PortfolioBaseData do
    
    full_name "Avid Beaver" 
    last_trade "168.34393" 
    close "164.83158"
    ticker "AVIDBEAVER" 
    eav_score "39.128" 
    facebook_score "43.730" 
    flickr_score "5.631" 
    foursquare_score "20.968" 
    gplus_score "1.000" 
    instagram_score "23.266" 
    linkedin_score "29.677" 
    twitter_score "40.820" 
    youtube_score "1.324"
  end  
  
  factory :search_recent_data, class: EmpireAvenue::Rspec::API::SearchRecentData do
    
    ticker "AVIDBEAVER" 
    full_name "Avid Beaver" 
    last_trade "168.34393" 
    close "164.83158" 
    sm_portrait "https://s3.amazonaws.com/empireavenue-public/portraits/p_sm_AVIDBEAVER_7b1b50ba737e.jpg" 
    lg_portrait "https://s3.amazonaws.com/empireavenue-public/portraits/p_lg_AVIDBEAVER_7b1b50ba737e.jpg" 
    outstanding_shares "349086" 
    country "World" 
    created "2012-12-12 12:12:12" 
    max_shares 1400 
    eav_score "39.128" 
    facebook_score "43.730" 
    flickr_score "5.631" 
    foursquare_score "20.968" 
    gplus_score "1.000" 
    instagram_score "23.266" 
    linkedin_score "29.677" 
    twitter_score "40.820" 
    youtube_score "1.324"    
  end

  factory :shares_buy_data, class: EmpireAvenue::Rspec::API::SharesBuyData do
    success true
    shares_owned 1228
    commission 7
    total_charged 2298.09312
    bank_balance "890111234.12345"
  end

  factory :shares_sell_data, class: EmpireAvenue::Rspec::API::SharesSellData do
    success true
    shares_owned 1228
    commission 7
    bank_balance "890111234.12345"
    total_earned 2298.09312
  end  
  
end
  