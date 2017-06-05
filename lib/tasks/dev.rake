namespace :dev do
  task :fetch_stock => :environment do
    puts "Fetch stock data..."
    for i in 1...10 do

      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usaall",
      :params => { :page => "#{i}", :type => "3", :key => "1753b50e7ab450d42109babc43ae9c3a" }

      data = JSON.parse(response.body)

      data["result"].each do |c|
        existing_stock = Stock.find_by_gid( c.first["symbol"] )
        if existing_stock.nil?
            Stock.create!( :gid => c.first["symbol"], :name => c.first["cname"] )
        end
      end
    end
    puts "Total :#{Stock.count} stocks"
  end
end
