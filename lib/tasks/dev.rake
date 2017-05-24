namespace :dev do
  task :fetch_stock => :environment do
    puts "Fetch stock data..."
    response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usaall", :params => { :key => "1753b50e7ab450d42109babc43ae9c3a" }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_stock = Stock.find_by_gid( c["symbol"] )
      if existing_stock.nil?
        Stock.create!( :gid => c["symbol"], :name => c["cname"], :price => c["price"],
                       :markvalue => c["mktcap"] )
      end
    end
    puts "Total :#{Stock.count} stocks"
  end
end
