# encoding: utf-8
require 'json'
require 'csv'
file = File.read('reactjs.json')
data_hash = JSON.parse(file)
# puts data_hash[1]
hash = {}
cout = 0
data_hash.each do |data|
  next if data['html'].nil?
  if data['html'].length >= 1
    new = data['html'].downcase
    rs =  new.gsub!(/(<[^>]*>)|\n|\t|[.,]/u) {""}
    arr = rs.split
    arr.each do |item|
      if (/^([A-Za-z])+$/u).match?(item)
        if hash.key?(item)
          hash[item] += 1
        else
          cout+=1
          hash[item] = 1
        end
      end
    end
  end
end
puts hash
hash = hash.sort_by {|_key, value| -value}.to_h
CSV.open("reactjs1.csv", "w") do |csv|
  hash.each {|key, value| csv << ["#{key}", "#{value}"] }
end
