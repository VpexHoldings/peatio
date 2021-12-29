### /api/v2/trade/p2p/member/p2p_orders

#### GET

##### Description

Member list P2pOrder

##### Parameters

```ruby
{
  status: "1,2,3", # 0: ordered, 1: transfer, 2: paid, 3: complete, 4:cancel, nil: all
  p2p_orders_type: 0, # 0:sell, 1:buy, nil: all
  order_number: "4a3318e6f7c7" # no data: nil 
}
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

#--------------------------------------------------------------------------
### api/v2/trade/p2p/p2p_orders

#### POST

##### Description

Create P2pOrder

##### Parameters

```ruby
{
  "p2p_orders_type": "sell",
  "advertisement_id": "21",
  "number_of_coin": "1",
  "price": 1234 #(optional if advertisement is floating)
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
    "attachments": [
      {
        image: "data_image"
      },
      {
        image: "data_image"
      }
    ]
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


