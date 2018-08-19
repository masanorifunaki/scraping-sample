scrapingHandler = require '../functions/scraping-handler'

url = 'https://www.neweconomy.jp/'
findSelectorForSetObj = '.p-article__inner'
SetObj =
  _id: '.p-article__link@href'
  title: '.p-article__title'
  link: '.p-article__link@href'
mediaName = 'あたらしい経済'
mediaLink = 'https://www.neweconomy.jp'

scrapingHandler.scrapingToSave(url, findSelectorForSetObj, SetObj, mediaName, mediaLink).then (result) =>
  console.log result