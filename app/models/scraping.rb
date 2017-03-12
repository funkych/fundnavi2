class Scraping

  def self.fundinfo
    # ここに処理を書く
    links = [] # 個別ページのリンクを保存する配列
    agent = Mechanize.new

    current_page = agent.get("http://kakaku.com/fund/result.asp")
    elements = current_page.search('.cellName a')
    elements.each do |ele|
     links << ele[:href]
    end

    links.each do |link|
      puts get_product('http://kakaku.com/fund/' + link)
    end

  end

  def self.get_product(link)
    # ここに処理を書く
    agent = Mechanize.new
    page = agent.get(link)

    name = page.at('.inner h2').inner_text if page.at('.inner h2')

    company = page.at('.comInfo dd').inner_text if page.at('.comInfo dd')
    character = page.at('.tokuchoBtm li').inner_text if page.at('.tokuchoBtm li')
    category = page.at('.spec1 td').inner_text if page.at('.spec1 td')
    investarea =page.at('.spec3 td').inner_text if page.at('.spec3 td')

    investarea= investarea.gsub(/[\r\n]/,"")

    product = Product.where(name: name).first_or_initialize
    product.company = company
    product.character = character
    product.category = category
    product.investarea = investarea
    product.save
  end
end