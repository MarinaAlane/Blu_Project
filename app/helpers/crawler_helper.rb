module CrawlerHelper
  URL = "https://repnota1000.blu.com.br/"
  DEPARTMENTS = "/api/v1/departments"
  SUPPLIERS = ->(category) { "#{URL}/api/v1/suppliers?name=&department_slugs[]=#{category}&sub_department_slugs[]=&position_slugs[]=&order=&page=1&per_page=100" }
end