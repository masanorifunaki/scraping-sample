router      = require('express').Router()
MongoClient = require('mongodb').MongoClient
_           = require 'lodash'
moment      = require 'moment'

URL         = process.env.MONGODB_URI || 'mongodb://localhost:27017/'
DATABASE    = process.env.DATABASE || 'articles'

router.get '/*', (req, res, next) =>
  page = if req.query.page then req.query.page - 0 else 1

  MongoClient.connect URL, useNewUrlParser: true, (err, db) =>
    throw err if err

    db = db.db 'heroku_8nzt1zr3'

    Promise.all [
      db.collection('articles')
        .find()
        .count()
      db.collection('articles')
        .find()
        .sort createdAt: -1
        .skip (page - 1) * 10
        .limit 10
        .toArray()
    ]
    .then (results) ->
      # 表示用に整形
      _.each results[1], (article) ->
        article.createdAt = moment(article.createdAt).utcOffset('+0900').format('YYYY年MM月DD日')
      count = results[0]
      renderArticles =
        articles: results[1]
        pagination:
          max: count / 10
          current: page
      res.render 'index', renderArticles
    .catch()

module.exports = router