### api/v2/trade/p2p/advertisements

#### POST

##### Description

Create Advertisements

##### Parameters

```ruby
{
  "advertisement": {
    "advertis_type": "sell",
    "currency_id": "btc",
    "currency_payment_id": "eth",
    "price_type": "floating",
    "total_amount": "100000",
    "upper_limit": "50000",
    "lower_limit": "30000",
    "description": "mua tien ao",
    "visible": "enabled",
    "price_percent": "1000000000000000",
    "expired_time": 2, #(Tính bằng phút)
    "member_registration_day": 10,
    "member_coin_number": 10,
    "is_kyc": 1
  },
  "payment_method_ids": [1, 3]
}

{
  "advertisement": {
    "advertis_type": "sell",
    "currency_id": "btc",
    "currency_payment_id": "eth",
    "price_type": "fixed",
    "total_amount": "100000",
    "upper_limit": "50000",
    "lower_limit": "30000",
    "description": "mua tien ao",
    "visible": "enabled",
    "price": "1000000000000000",
    "expired_time": 2, #(Tính bằng phút)
    "member_registration_day": 10,
    "member_coin_number": 10,
    "is_kyc": 1
  },
  "payment_method_ids": [1, 3]
}
```

##### Responses

success:

```ruby
{
  "id": 21,
  "price": "1000000000000000.0",
  "expired_time": 15,
  "advertis_type": "sell",
  "avaiable_coin": "0.96",
  "upper_limit": "50000.0",
  "lower_limit": "30000.0",
  "description": "mua tien ao",
  "currency": {
    "id": "btc",
    "name": "Bitcoin",
    "description": null,
    "homepage": null,
    "price": "1.0",
    "type": "coin",
    "precision": 8,
    "position": 3
  },
  "creator": {
    "username": null
  },
  "payment_methods": [
    {
      "payment_type": "bank_transfer",
      "account_number": "123456789",
      "bank_name": "thai",
      "account_name": "hoangthai"
    },
    {
      "payment_type": "",
      "account_number": "123456",
      "bank_name": "vietcombank",
      "account_name": "thaidang"
    }
  ],
  "currency_payment_id": "eth",
  "price_type": "fixed",
  "total_amount": "100000.0"
}
```

errors:

```ruby
    [
      "p2p.advertisement.missing_description",
      "p2p.advertisement.missing_visible",
      "p2p.advertisement.missing_price"
    ]
```

## ---------------------------------------------------------------------



## /api/v2/trade/p2p/my_advertises

#### GET

##### Description

GET ALL MY ADVERTIS

##### Parameters

```ruby
{
  visible: 0, # 0: disabled, 1: enabled, nil: all
  advertis_type: 0, # 0:sell, 1:buy, nil: all
  currency_id: "btc", # no data: nil, eth, usdt,...
  currency_payment_id: "vnd", # no data: nil, usd,,...
  price_type: 0, # 0:fixed, 1: floating
  start_date: "2021-12-12",
  end_date: "2021-30-12",
  page: 1,
  limit: 15
}

#all field is optional 
```

##### Responses

success:

```ruby

[
  {
    "id": 119,
    "price": "23640.0",
    "expired_time": 15,
    "advertis_type": "buy",
    "coin_avaiable": 0.7698815566835897,
    "upper_limit": "200000.0",
    "lower_limit": "100000.0",
    "description": "Today SNT test",
    "price_percent": 100,
    "currency": {
      "id": "usdt",
      "name": "Tether",
      "description": null,
      "homepage": null,
      "price": "1.0",
      "type": "coin",
      "precision": 8,
      "position": 1
    },
    "creator": {
      "id": 2,
      "email": "admin@zsmart.tech",
      "created_at": "2021-11-29T06:44:43.980Z",
      "updated_at": "2021-12-23T03:53:10.312Z",
      "uid": "ID123260D6EB",
      "level": 3,
      "role": "admin",
      "state": "active",
      "group": "vip-0",
      "username": null,
      "referral_uid": null,
      "beneficiaries_whitelisting": true
    },
    "payment_methods": [
      {
        "id": 3,
        "payment_type": "bank_transfer",
        "account_number": "1234455",
        "bank_name": "vcb",
        "account_name": "Nguyen Thi Ha"
      }
    ],
    "currency_payment_id": "vnd",
    "price_type": "fixed",
    "visible": "enabled",
    "created_at": "2021-12-23T04:03:06.692Z",
    "total_amount": "10.0"
  }
]

```
##----------------------------------------------------------------------
## /api/v2/trade/p2p/my_advertise/:id

#### GET

##### Description

SHOW A MY ADVERTIS

##### Parameters

```ruby
{}

```

##### Responses

success:

```ruby

[
  {
    "id": 119,
    "price": "23640.0",
    "expired_time": 15,
    "advertis_type": "buy",
    "coin_avaiable": 0.7698815566835897,
    "upper_limit": "200000.0",
    "lower_limit": "100000.0",
    "description": "Today SNT test",
    "price_percent": 100,
    "currency": {
      "id": "usdt",
      "name": "Tether",
      "description": null,
      "homepage": null,
      "price": "1.0",
      "type": "coin",
      "precision": 8,
      "position": 1
    },
    "creator": {
      "id": 2,
      "email": "admin@zsmart.tech",
      "created_at": "2021-11-29T06:44:43.980Z",
      "updated_at": "2021-12-23T03:53:10.312Z",
      "uid": "ID123260D6EB",
      "level": 3,
      "role": "admin",
      "state": "active",
      "group": "vip-0",
      "username": null,
      "referral_uid": null,
      "beneficiaries_whitelisting": true
    },
    "payment_methods": [
      {
        "id": 3,
        "payment_type": "bank_transfer",
        "account_number": "1234455",
        "bank_name": "vcb",
        "account_name": "Nguyen Thi Ha"
      }
    ],
    "currency_payment_id": "vnd",
    "price_type": "fixed",
    "visible": "enabled",
    "created_at": "2021-12-23T04:03:06.692Z",
    "total_amount": "10.0"
  }
]

```
errors:
```azure
"ads not found!"
```
#------------------------------------------------------------------------------
## /api/v2/trade/p2p/my_advertise/119

#### POST

##### Description

UPDATE A MY ADVERTIS

##### Parameters

```ruby
{
  "advertisement": {
    "advertis_type": "sell", #sell/buy
    "currency_id": "usdt",
    "currency_payment_id": "vnd",
    "price_type": "fixed", #fixed/floating
    "total_amount": 10,
    "upper_limit": "10000",
    "lower_limit": "1000000",
    "description": "test",
    "visible": 0, #0/1
    "expired_time": 15, #minute
    "price": "100", # with fixed
    "price_percent": 100 #with floating
  },
  "payment_method_ids": [1,2]
}
```

##### Responses

success:

```ruby

[
  {
    "id": 119,
    "price": "23640.0",
    "expired_time": 15,
    "advertis_type": "buy",
    "coin_avaiable": 0.7698815566835897,
    "upper_limit": "200000.0",
    "lower_limit": "100000.0",
    "description": "Today SNT test",
    "price_percent": 100,
    "currency": {
      "id": "usdt",
      "name": "Tether",
      "description": null,
      "homepage": null,
      "price": "1.0",
      "type": "coin",
      "precision": 8,
      "position": 1
    },
    "creator": {
      "id": 2,
      "email": "admin@zsmart.tech",
      "created_at": "2021-11-29T06:44:43.980Z",
      "updated_at": "2021-12-23T03:53:10.312Z",
      "uid": "ID123260D6EB",
      "level": 3,
      "role": "admin",
      "state": "active",
      "group": "vip-0",
      "username": null,
      "referral_uid": null,
      "beneficiaries_whitelisting": true
    },
    "payment_methods": [
      {
        "id": 3,
        "payment_type": "bank_transfer",
        "account_number": "1234455",
        "bank_name": "vcb",
        "account_name": "Nguyen Thi Ha"
      }
    ],
    "currency_payment_id": "vnd",
    "price_type": "fixed",
    "visible": "enabled",
    "created_at": "2021-12-23T04:03:06.692Z",
    "total_amount": "10.0"
  }
]

```
##----------------------------------------------------------------------
