require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    array = []
    site = "https://learn-co-curriculum.github.io/student-scraper-test-page/"
    scrape = Nokogiri::HTML(open(site))
    student_name=Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/")).css(".student-card").css("h4").text
    student_location=Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/")).css(".student-card").css("p").text
    student_url=Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/")).css(".student-card").css("a").attribute("href").value
    #binding.pry
    scrape.css(".student-card").each do |student|
      student_hash = {
        :name => student.css("h4").text,
        :location => student.css("p").text,

        :profile_url => student.css("a").attribute("href").value
      }
      array << student_hash
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    array=[]
    scrape= Nokogiri::HTML(open(profile_url))
    scrape.css(".social-icon-container").css("a").each do |link|
       array << link.attribute("href").value
     end

      twitter = array.find{|x| x[/twitter/]}
      linkedin = array.find{|x| x[/linkedin/]}
      github = array.find{|x| x[/github/]}
      blog = array.find{|x| !x[/twitter/] && !x[/linkedin/] && !x[/github/] && x != nil}
      profile_quote = scrape.css(".vitals-text-container").css("div.profile-quote").text
      bio = scrape.css(".description-holder").css("p").text

    binding.pry
  end

end
