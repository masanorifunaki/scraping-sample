router      = require('express').Router()
MongoClient = require('mongodb').MongoClient
_           = require 'lodash'
moment      = require 'moment'
URL         = 'mongodb://localhost:27017/'

router.get '/', (req, res, next) =>
  MongoClient.connect URL, useNewUrlParser: true, (err, db) =>
    throw err if err

    db = db.db 'articles'
    sortCondition =
      createdAt: -1

    db.collection('articles').find().sort(sortCondition).toArray().then (articles) =>
      # 表示用に整形
      _.each articles, (article) ->
        article.createdAt = moment(article.createdAt).utcOffset('+0900').format('YYYY年MM月DD日')

      renderArticles =
        articles: articles

      res.render 'index', renderArticles

module.exports = router