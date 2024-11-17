#!/bin/zsh

# ビルド生成したものだけ、git管轄のフォルダへ移動
rm -rf /Users/bonji/workspace/www.mikuro.works/shuji/study_notes/restful-webapi/*
rsync -av site/ /Users/bonji/workspace/www.mikuro.works/shuji/study_notes/restful-webapi/

# amazon S3 バケットの同期
aws s3 sync /Users/bonji/workspace/www.mikuro.works/shuji/study_notes/restful-webapi/ s3://www.mikuro.works/shuji/study_notes/restful-webapi/

# amazon CloudFront キャッシュをinvalidate
aws cloudfront create-invalidation --distribution-id E1KST3JF0JFTX2 --paths "/shuji/study_notes/restful-webapi/*"
