# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
|email|string|null:false, unique:true|
|encrypted_password|string|null:false|

### Association
- has_one:plofile
- has_one: destination
- has_one:credit_card
- has_many:products
- has_many: comments
- has_many:likes
- has_many:to-do_lists
- has_many:notices

## profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null:false|
|family_name|string|null:false|
|first_name_kana|string|null:false|
|family_name_kana|string|null:false|
|birth_year|integer|null:false|
|birth_month|integer|null:false|
|birth_day|integer|null:false|
|user|refrences|null:false,foreign_key:true|

### Association
- belongs_to:user

## destinationsテーブル
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null:false|
|destination_family_name|string|null:false|
|destination_first_name_kana|string|null:false|
|destination_family_name_kana|string|null:false|
|postal_code|string(7)|null:false|
|prefecture|string|null:false|
|city|string|null:false|
|address|string|null:false|
|building|string|
|phone_number|string|
|user|references|null:false,foreigin_key:true|

### Association
- belongs_to:user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null:false|
|description|text|null:false|
|postage|integer|null:false|
|condition|integer|null:false,default:0|
|price|integer|null:false|
|status|integer|null:false,default:0|
|user|references|null:false,foreign_key:true|
|comment|references| null:false,foreign_key:true|
|brand|references|foreign_key:true|
|image|references|null:false,foreign_key:true|
|like|references|foreign_key:true|
|category|references|null:false,foreign_key:true|
|prefecture_id|integer|null:false|
|sipping_day_id|integer|null:false|

### enum
- enum condition:{brand_new: 1, look_brand_new: 2, no_noticeable_scratches: 3, some_scratches: 4, noticeable_scratches: 5, bad_condition: 6}
- enum postage: {including_shipping_fee: 1, cash_on_delivery: 2}
- enum status: {on_display: 0, sold: 1}
### Association
- belongs_to: user
- belongs_to: brand
- belongs_to: category
- has_many: images,dependent::destroy
- has_many: commemts,dependent::destroy
- has_many: likes,dependent::destroy
- belongs_to: active_hash: shipping_day
- belongs_to:active_hash: prefecture

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null:false,foreign_key:true|
|card_id|integer|null:false|
|customer_id|integer|null:false|

### Association
- belongs_to:user

## noticesテーブル
|Column|Type|Options|
|------|----|-------|
|list|text|null:false|
|user|references|null:false, foreign_key:true|

### Association
- belongs_to:user

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|ancestry|string|

### Asociation
- has_many :products
- has_ancestry
## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|brand_name|string|null:false|

### Asociation
- has_many :products

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null:false, foreign_key: true|
|product|refrences|null:false, foreign_key:true|
|comment|text|null:false|

### Asociation
- belongs_to :user
- belongs_to :product

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null:false,foreign_key: true|
|product|references|null:false, foreign_key: true|

### Asociation
- belongs_to :user
- belongs_to :product

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|string|null:false|
|product|references|null:false, foreign_key: true|

### Asociation
- belongs_to :product

## to-do_listsテーブル
|Column|Type|Options|
|------|----|-------|
|list|text|null:false|
|user|references|null:false, foreign_key: true|

### Asociation
- belongs_to :user
