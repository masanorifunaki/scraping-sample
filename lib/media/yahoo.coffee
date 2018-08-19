scrapingHandler = require '../functions/scraping-handler'

url = 'https://news.yahoo.co.jp/hl?c=c_ent'
findSelectorForSetObj = '.listFeedWrap'
SetObj =
  _id: 'a@href'
  title: '.titl'
  link: 'a@href'
  mediaName: '.source > span:first-child'

followSelectorForSetMedia = 'a@href'
SetMedia =
  mediaLink: '.ynCobrandBanner a@href'

scrapingHandler.scrapingToSaveFollowMedia(url, findSelectorForSetObj, SetObj, followSelectorForSetMedia, SetMedia).then (result) =>
  console.log result