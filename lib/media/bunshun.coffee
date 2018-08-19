scrapingHandler = require '../functions/scraping-handler'

url = 'http://bunshun.jp/subcategory/%E3%82%A8%E3%83%B3%E3%82%BF%E3%83%A1'
findSelectorForSetObj = '.list-thumb > li'
SetObj =
  _id: '.title > a@href'
  title: '.title > a'
  link: '.title > a@href'
mediaName = '週刊文春'
mediaLink = 'http://bunshun.jp'

scrapingHandler.scrapingToSave(url, findSelectorForSetObj, SetObj, mediaName, mediaLink).then (result) =>
  console.log result