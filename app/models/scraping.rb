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
      puts scraping_image('http://kakaku.com/fund/' + link)
    end

  end

  def self.get_product(link)
    # ここに処理を書く
    agent = Mechanize.new
    page = agent.get(link)
 
    name = page.at('.inner h2').inner_text
    company = page.at('.comInfo dd').inner_text
    character = page.at('.tokuchoBtm li').inner_text
    category = page.at('.spec1 td').inner_text
    investarea =page.at('.spec3 td').inner_text

    product = Product.new(name: name, company: company, character: character, category: category, investarea: investarea)
    product.save
  end
end