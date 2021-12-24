# P2p API v2

### api/v2/trade/public/advertises

#### GET

##### Description

Show all advertis with type(sell/buy)

##### Parameters
```
{ 
    advertis_type: buy #(buy/sell)
    page:1
    currency_id: usdt #(btc, usdt, eth...)
    limit: 30
```

##### Responses
```azure
[
    {
        "id": 69,
        "price": "23640.0",
        "expired_time": 15,
        "advertis_type": "buy",
        "avaiable_coin": "10000000.0",
        "upper_limit": "62.0",
        "lower_limit": "6.0",
        "description": "",
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
            "username": null
        },
        "payment_methods": [
            {
                "id": 1,
                "payment_type": "bank_transfer",
                "account_number": "12345667",
                "bank_name": "vcb",
                "account_name": "Nguyen Thi Ha"
            }
        ],
        "currency_payment_id": "vnd",
        "price_type": "fixed",
        "total_amount": "5.0"
    },
    {
        "id": 73,
        "price": "23640.0",
        "expired_time": 15,
        "advertis_type": "buy",
        "avaiable_coin": "9999918.0",
        "upper_limit": "4.0",
        "lower_limit": "3.0",
        "description": "",
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
            "username": null
        },
        "payment_methods": [
            {
                "id": 1,
                "payment_type": "bank_transfer",
                "account_number": "12345667",
                "bank_name": "vcb",
                "account_name": "Nguyen Thi Ha"
            }
        ],
        "currency_payment_id": "vnd",
        "price_type": "fixed",
        "total_amount": "9999917.0"
    },
    {
        "id": 74,
        "price": "23640.0",
        "expired_time": 15,
        "advertis_type": "buy",
        "avaiable_coin": "9999918.0",
        "upper_limit": "5.0",
        "lower_limit": "4.0",
        "description": "test abc 1",
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
            "username": null
        },
        "payment_methods": [
            {
                "id": 1,
                "payment_type": "bank_transfer",
                "account_number": "12345667",
                "bank_name": "vcb",
                "account_name": "Nguyen Thi Ha"
            }
        ],
        "currency_payment_id": "vnd",
        "price_type": "fixed",
        "total_amount": "3.0"
    }
]
```

### api/v2/trade/p2p/advertises (use after login)

#### GET

##### Description

Show all advertis with type(sell/buy)

##### Parameters
```
{ 
    advertis_type: buy #(buy/sell)
    page:1
    currency_id: usdt #(btc, usdt, eth...)
    limit: 30
    payment_method_type: 'bank_transfer' 
```

##### Responses
```azure
[
    {
        "id": 69,
        "price": "23640.0",
        "expired_time": 15,
        "advertis_type": "buy",
        "avaiable_coin": "10000000.0",
        "upper_limit": "62.0",
        "lower_limit": "6.0",
        "description": "",
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
            "username": null
        },
        "payment_methods": [
            {
                "id": 1,
                "payment_type": "bank_transfer",
                "account_number": "12345667",
                "bank_name": "vcb",
                "account_name": "Nguyen Thi Ha"
            }
        ],
        "currency_payment_id": "vnd",
        "price_type": "fixed",
        "total_amount": "5.0"
    },
    {
        "id": 73,
        "price": "23640.0",
        "expired_time": 15,
        "advertis_type": "buy",
        "avaiable_coin": "9999918.0",
        "upper_limit": "4.0",
        "lower_limit": "3.0",
        "description": "",
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
            "username": null
        },
        "payment_methods": [
            {
                "id": 1,
                "payment_type": "bank_transfer",
                "account_number": "12345667",
                "bank_name": "vcb",
                "account_name": "Nguyen Thi Ha"
            }
        ],
        "currency_payment_id": "vnd",
        "price_type": "fixed",
        "total_amount": "9999917.0"
    },
    {
        "id": 74,
        "price": "23640.0",
        "expired_time": 15,
        "advertis_type": "buy",
        "avaiable_coin": "9999918.0",
        "upper_limit": "5.0",
        "lower_limit": "4.0",
        "description": "test abc 1",
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
            "username": null
        },
        "payment_methods": [
            {
                "id": 1,
                "payment_type": "bank_transfer",
                "account_number": "12345667",
                "bank_name": "vcb",
                "account_name": "Nguyen Thi Ha"
            }
        ],
        "currency_payment_id": "vnd",
        "price_type": "fixed",
        "total_amount": "3.0"
    }
]
```


### api/v2/trade/p2p/p2p_order/:id

#### POST

##### Description

Update status of P2pOrder(ordered/paid/complete/cancel)

##### Parameters

```ruby
{
  "status": "paid", #(ordered transfer paid complete cancel)
  "payment_method_id": 1
}
```

##### Responses

success:

```ruby
{
  "response_message": "{\"error\":\"management.phone.doesnt_exists\"}",
  "order": {
    "id": 97,
    "status": "paid",
    "p2p_orders_type": "sell",
    "price": "1000000000000000.0",
    "ammount": "100000000000000.0",
    "number_of_coin": "0.1",
    "order_number": "ec93a475a8a0",
    "payment_method": {
      "payment_type": "bank_transfer",
      "account_number": "123456789",
      "bank_name": "thai",
      "account_name": "hoangthai"
    },
    "advertisement": {
      "id": 40,
      "price": "1000000000000000.0",
      "expired_time": 2,
      "advertis_type": "sell",
      "avaiable_coin": "2.0",
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
    },
    "member_id": 2
  }
}
```

errors:

```ruby
update fail!
```

### api/v2/trade/p2p/p2p_orders

#### POST

##### Description

Create P2pOrder

##### Parameters

```ruby
{
  "p2p_orders_type": "sell",
  "advertisement_id": "21",
  "number_of_coin": "1"
}
```

##### Responses

success:

```ruby

{
  "response_message": "{\"error\":\"management.phone.doesnt_exists\"}",
  "order": {
    "id": 100,
    "status": "ordered",
    "p2p_orders_type": "sell",
    "price": "1000000000000000.0",
    "ammount": "100000000000000.0",
    "number_of_coin": "0.1",
    "order_number": "f93df7b25bbf",
    "payment_method": null,
    "advertisement": {
      "id": 44,
      "price": "1000000000000000.0",
      "expired_time": 2,
      "advertis_type": "sell",
      "avaiable_coin": "6.82",
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
    },
    "member_id": 2,
    "claim_status": null,
    "claim_description": null,
    "claim_title": null,
    "images": {
      "name": "images",
      "record": {
        "id": 100,
        "member_id": 2,
        "status": "ordered",
        "p2p_orders_type": "sell",
        "price": "1000000000000000.0",
        "ammount": "100000000000000.0",
        "advertis_payment_method_id": null,
        "order_number": "f93df7b25bbf",
        "advertisement_id": 44,
        "number_of_coin": "0.1",
        "payment_method_id": null,
        "created_at": "2021-12-13T09:28:00.691Z",
        "claim_title": null,
        "claim_status": null,
        "claim_description": null
      },
      "dependent": "purge_later"
    }
  }
}

```

errors:

```ruby
    [
      "p2p.p2porder.missing_number_of_coin",
      "p2p.p2p_order.non_positive_number_of_coin"
    ]
```

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
    "price_type": "fixed",
    "total_amount": "100000",
    "upper_limit": "50000",
    "lower_limit": "30000",
    "description": "mua tien ao",
    "visible": "enabled",
    "price": "1000000000000000",
    "expired_time": 2 #(Tính bằng phút)
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

### /api/v2/trade/p2p/member/p2p_orders

#### GET

##### Description

Member show list P2pOrder

##### Parameters

```ruby

```

##### Responses

success:

```ruby

[
  {
    "id": 51,
    "member_id": 2,
    "status": "ordered",
    "p2p_orders_type": "sell",
    "price": "1000000000000000.0",
    "ammount": "10000000000000.0",
    "advertis_payment_method_id": null,
    "order_number": "3ec5dabfb279",
    "advertisement_id": 40,
    "number_of_coin": "0.01",
    "payment_method_id": null,
    "created_at": "2021-12-06T12:17:19.983Z"
  },
  {
    "id": 52,
    "member_id": 2,
    "status": "ordered",
    "p2p_orders_type": "sell",
    "price": "1000000000000000.0",
    "ammount": "10000000000000.0",
    "advertis_payment_method_id": null,
    "order_number": "02872e0d6a23",
    "advertisement_id": 40,
    "number_of_coin": "0.01",
    "payment_method_id": null,
    "created_at": "2021-12-06T12:17:47.768Z"
  },
  {
    "id": 53,
    "member_id": 2,
    "status": "ordered",
    "p2p_orders_type": "sell",
    "price": "1000000000000000.0",
    "ammount": "10000000000000.0",
    "advertis_payment_method_id": null,
    "order_number": "77e7f1284987",
    "advertisement_id": 40,
    "number_of_coin": "0.01",
    "payment_method_id": null,
    "created_at": "2021-12-06T12:20:55.524Z"
  }
]

```

### /api/v2/trade/p2p/admin/:id/p2p_orders

#### GET

##### Description

Admin show list P2pOrder of Member

##### Parameters

```ruby

```

##### Responses

success:

```ruby

[
  {
    "id": 51,
    "member_id": 2,
    "status": "ordered",
    "p2p_orders_type": "sell",
    "price": "1000000000000000.0",
    "ammount": "10000000000000.0",
    "advertis_payment_method_id": null,
    "order_number": "3ec5dabfb279",
    "advertisement_id": 40,
    "number_of_coin": "0.01",
    "payment_method_id": null,
    "created_at": "2021-12-06T12:17:19.983Z"
  },
  {
    "id": 52,
    "member_id": 2,
    "status": "ordered",
    "p2p_orders_type": "sell",
    "price": "1000000000000000.0",
    "ammount": "10000000000000.0",
    "advertis_payment_method_id": null,
    "order_number": "02872e0d6a23",
    "advertisement_id": 40,
    "number_of_coin": "0.01",
    "payment_method_id": null,
    "created_at": "2021-12-06T12:17:47.768Z"
  },
  {
    "id": 53,
    "member_id": 2,
    "status": "ordered",
    "p2p_orders_type": "sell",
    "price": "1000000000000000.0",
    "ammount": "10000000000000.0",
    "advertis_payment_method_id": null,
    "order_number": "77e7f1284987",
    "advertisement_id": 40,
    "number_of_coin": "0.01",
    "payment_method_id": null,
    "created_at": "2021-12-06T12:20:55.524Z"
  }
]

```

### api/v2/trade/p2p/p2p_order/:id/claim

#### POST

##### Description

Create POST claim P2pOrder

##### Parameters

```ruby
{
  "claim_title": "Others",
  "claim_description": "have not recieved the money",
  "claim_status": 0
}
```

##### Responses

```ruby
{
  "id": 82,
  "claim_title": "Others",
  "claim_description": "have not recieved the money",
  "claim_status": "request",
  "order_number": "e946803f8a40",
  "created_at": "2021-12-06T15:07:33.264Z"
}
```

### api/v2/trade/p2p/admin/p2p_order/claims

#### GET

##### Description

Admin list claim P2pOrder

##### Parameters

```ruby

```

##### Responses

```ruby
[
  {
    "id": 140,
    "claim_title": "Others",
    "claim_description": "have not recieved the money",
    "claim_status": "request",
    "order_number": "99e5401308a2",
    "images": {
      "name": "images",
      "record": {
        "id": 140,
        "member_id": 2,
        "status": "paid",
        "p2p_orders_type": "sell",
        "price": "1000000000000000.0",
        "ammount": "1000000000000000.0",
        "advertis_payment_method_id": null,
        "order_number": "99e5401308a2",
        "advertisement_id": 56,
        "number_of_coin": "1.0",
        "payment_method_id": 1,
        "created_at": "2021-12-14T10:53:20.939Z",
        "claim_title": "Others",
        "claim_status": "request",
        "claim_description": "have not recieved the money"
      },
      "dependent": "purge_later"
    },
    "created_at": "2021-12-14T10:53:20.939Z"
  },
  {
    "id": 141,
    "claim_title": "Others",
    "claim_description": "I made the payment, but the seller did not release the cryptocurrencies",
    "claim_status": "request",
    "order_number": "dac608bf12cb",
    "images": {
      "name": "images",
      "record": {
        "id": 141,
        "member_id": 2,
        "status": "paid",
        "p2p_orders_type": "sell",
        "price": "1000000000000000.0",
        "ammount": "5000000000000000.0",
        "advertis_payment_method_id": null,
        "order_number": "dac608bf12cb",
        "advertisement_id": 57,
        "number_of_coin": "5.0",
        "payment_method_id": 1,
        "created_at": "2021-12-14T10:54:22.462Z",
        "claim_title": "Others",
        "claim_status": "request",
        "claim_description": "I made the payment, but the seller did not release the cryptocurrencies"
      },
      "dependent": "purge_later"
    },
    "created_at": "2021-12-14T10:54:22.462Z"
  },
  {
    "id": 142,
    "claim_title": "Others",
    "claim_description": "Pay the seller extra money",
    "claim_status": "request",
    "order_number": "a1d574d2c7bc",
    "images": {
      "name": "images",
      "record": {
        "id": 142,
        "member_id": 3,
        "status": "paid",
        "p2p_orders_type": "sell",
        "price": "1000000000000000.0",
        "ammount": "5000000000000000.0",
        "advertis_payment_method_id": null,
        "order_number": "a1d574d2c7bc",
        "advertisement_id": 60,
        "number_of_coin": "5.0",
        "payment_method_id": 1,
        "created_at": "2021-12-14T10:56:16.177Z",
        "claim_title": "Others",
        "claim_status": "request",
        "claim_description": "Pay the seller extra money"
      },
      "dependent": "purge_later"
    },
    "created_at": "2021-12-14T10:56:16.177Z"
  }
]
```

### api/v2/trade/p2p/admin/p2p_orders/:id/approve

#### POST

##### Description

Admin approve succes order

##### Parameters

```ruby
{
  "status": "complete"
}
```

##### Responses

```ruby
{
  "complete_order": true,
  "response_message": "{\"error\":\"content is empty\"}",
  "order": {
    "status": "complete",
    "id": 196,
    "member_id": 3,
    "p2p_orders_type": "buy",
    "price": "1000000000000000.0",
    "ammount": "40000000000000000.0",
    "advertis_payment_method_id": null,
    "order_number": "f1fdcf79e015",
    "advertisement_id": 102,
    "number_of_coin": "40.0",
    "payment_method_id": 1,
    "created_at": "2021-12-15T10:46:15.458Z",
    "claim_title": null,
    "claim_status": null,
    "claim_description": null
  }
}
```