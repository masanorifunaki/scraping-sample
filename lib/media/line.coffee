scrapingHandler = require '../functions/scraping-handler'

url = 'http://news.line.me/issue/entertainment'
findSelectorForSetObj = '.MdCMN03Article'
SetObj =
  _id: '.mdCMN03CiteWrap > a:first-child@href'
  title: '.mdCMN03AtclTtl'
  link: '.mdCMN03CiteWrap > a:first-child@href'
findSelectorForSetMedia = '.MdCMN03Article .mdCMN03AtclDataWrap'
SetMedia =
  mediaName: '.mdCMN03AtclImgQuotedBy'
  mediaLink: '.mdCMN03AtclImgQuotedBy@href'

scrapingHandler.scrapingToSaveFindMedia(url, findSelectorForSetObj, SetObj, findSelectorForSetMedia, SetMedia).then (result) =>
  console.log result