# encoding: utf-8
require 'json'
require "csv"
hash = Hash.new
csv_text = CSV.read("React.csv")
csv_text.each do |item|
  next if item[0].nil?
  next if item[0].empty?
  if hash.has_key?(item[0])
    hash[item[0]] = item[1].to_i + hash[item[0]]
  else
    hash[item[0]] = item[1].to_i
  end
end
csv_text1 = CSV.read("RoR.csv")
csv_text1.each do |item|
  next if item[0].empty?
  if hash.has_key?(item[0])
    hash[item[0]] = item[1].to_i + hash[item[0]]
  else
    hash[item[0]] = item[1].to_i
  end
end
hash = hash.sort_by {|_key, value| -value}.to_h
CSV.open("data.csv", "w") do |csv|
  hash.each {|key, value| csv << ["#{key}", "#{value}"] }
end
