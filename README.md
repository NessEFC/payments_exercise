# Payments Exercise

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.


## Schema

![Payments Exercise Back-end Schema](https://imgur.com/89k7OPM.png)


## API

- All API endpoints begin with `http://localhost:3000/api/v1`
- All responses are in JSON format
- Endpoints are RESTful

| Action | Path | Description | Parameters |
| ------- | ------- | ------- | ------- | 
| GET | /loans | returns a list of all loans in database | none |
| GET | /loans/:id | returns a single loan from the database | none |
| GET | /payments/:id | returns a single payment from the database | none |
| GET | /loans/:loan_id/payments | returns a list of payments for a given loan | none |
| POST | /loans/:loan_id/payments | create a single payment for a given loan | `amount` |


## Setup for Development

1. Clone this repo
1. Navigate to the root project directory
1. Checkout the branch `cn_0927_payments`
1. Run `bundle install` to install Gemfile dependencies
1. Create the database with `rake db:create`
1. Run migrations with `rake db:migrate`
1. Start the server with `rails s`
1. The table above contains all API endpoints found within the project


## Run Tests

- Run all tests with `rspec`
