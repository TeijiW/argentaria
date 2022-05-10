# Argentaria
A basic and small REST API made with Elixir and Phoenix for accounts

## Setup

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Great! Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Docs

### `/balance?account_id=1`
This endpoint will give the balance from requested account

### `/reset`
Endpoint to reset the accounts database

### `/events`
Endpoint to deposit, withdraw or transfer amount between accounts
#### **`deposit` event**
  Mandatory fields: 
  ```
  {
    "type": "deposit",
    "destination": "<account_id>",
    "amount": 0
  }
  ```

#### **`withdraw` event**
  Mandatory fields: 
  ```
  {
    "type": "withdraw",
    "origin": "<account_id>",
    "amount": 0
  }
  ```

#### **`transfer` event**
  Mandatory fields: 
  ```
  {
    "type": "transfer",
    "origin": "<account_id>",
    "destination": "<account_id>",
    "amount": 0
  }
  ```

## Rules

### Deposit
- When the **deposit** is made to a non-existing account, the account will be created with a `balance` equal to the deposited `amount`.
- When **deposit** is made to existing account, `amount` is added to the account balance 
### Withdraw
- When a **withdraw** is made from a non-existing account, the return is 404 http code with `"0"` text
- When **withdraw** is made from a existing account, `amount` is subtracted from the account `balance`
### Transfer
- When a **transfer** is made from a non-existing account to an existing account, the return is 404 http code with `"0"` text
- When **transfer** is made from a existing account to an existing account, `amount` is subtracted from the origin account `balance` and the `amount` is added to destination account `balance`