fs = require 'fs'

module.exports = ->
  res = []
  years = fs.readdirSync 'posts'
  for year in years
    months = fs.readdirSync "posts/#{year}"
    for month in months
      days = fs.readdirSync "posts/#{year}/#{month}"
      for day in days
        articles = fs.readdirSync "posts/#{year}/#{month}/#{day}"
        for article in articles
          res.push "posts/#{year}/#{month}/#{day}/#{article}"
  res
