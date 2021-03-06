osmosis     = require 'osmosis'
_           = require 'lodash'
moment      = require 'moment'
MongoClient = require('mongodb').MongoClient

URL         = process.env.MONGODB_URI || 'mongodb://localhost:27017/'
DATABASE    = process.env.DATABASE || 'articles'

scrapingToSave = (url, findSelectorForSetObj, SetObj, mediaName, mediaLink) =>
  new Promise (resolve, reject) =>
    result = 'OK'
    osmosis
      .get url
      .find findSelectorForSetObj
      .set SetObj
      .data (article) =>

        unless article._id?
          return article

        MongoClient.connect URL, { useNewUrlParser: true }, (err, db) =>
          throw err if err
          db = db.db DATABASE

          article.createdAt = moment().toDate()
          article.mediaName = mediaName
          article.mediaLink = mediaLink

          if article.link.match '^/.*'
            article.link = "#{article.mediaLink}#{article.link}"

          condition =
            _id: article._id
          update =
            $set: article

          try
            db.collection('articles').findOneAndUpdate(condition, update, upsert: true)
              .then (result) =>
                result
          catch e
            print e

      .done (err, result) =>
         if err
           reject err
          else
            resolve result

scrapingToSaveFindMedia = (url, findSelectorForSetObj, SetObj, findSelectorForSetMedia, SetMedia) =>
  new Promise (resolve, reject) =>
    result = 'OK'
    osmosis
      .get url
      .find findSelectorForSetObj
      .set SetObj
      .find findSelectorForSetMedia
      .set SetMedia
      .data (article) =>

        unless article._id?
          return article

        MongoClient.connect process.env.MONGODB_URI || URL, { useNewUrlParser: true }, (err, db) =>
          throw err if err
          db = db.db DATABASE

          article.createdAt = moment().toDate()
          condition =
            _id: article._id
          update =
            $set: article

          try
            db.collection('articles').findOneAndUpdate(condition, update, upsert: true)
              .then (result) =>
                result
          catch e
            print e

      .done () => resolve result

scrapingToSaveFollowMedia = (url, findSelectorForSetObj, SetObj, followSelectorForSetMedia, SetMedia) =>
  new Promise (resolve, reject) =>
    result = 'OK'
    osmosis
      .get url
      .find findSelectorForSetObj
      .set SetObj
      .follow followSelectorForSetMedia
      .set SetMedia
      .data (article) =>

        unless article._id?
          return article

        MongoClient.connect process.env.MONGODB_URI || URL, { useNewUrlParser: true }, (err, db) =>
          throw err if err
          db = db.db DATABASE

          article.createdAt = moment().toDate()
          condition =
            _id: article._id
          update =
            $set: article

          try
            db.collection('articles').findOneAndUpdate(condition, update, upsert: true)
              .then (result) =>
                result
          catch e
            print e

      .done () => resolve result

module.exports =
  scrapingToSave: scrapingToSave
  scrapingToSaveFindMedia: scrapingToSaveFindMedia
  scrapingToSaveFollowMedia: scrapingToSaveFollowMedia