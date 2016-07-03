# README

After cloning the Repository please setup your MongoDB on default port `27017`.

Run the Test's with these commands - 
Model Tests - `rake test test/models/bird_test.rb`
Integration Tests / API Tests - `rake test test/integration/bird_apis_test.rb`

API end points are as follows - 
1. Get all Birds - `/api/birds` - GET
2. Create New Bird - `/api/birds` - POST
3. Get Bird with ID - `/api/birds/{id}` - GET
4. Delete Bird with ID - `/api/birds/{id}` - DELETE
