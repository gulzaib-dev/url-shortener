# Rails URL Shortner App
This is a simple URL shortener application built with Ruby on Rails framework. The app allows users to input a long URL and generates a shortened URL that can be used to redirect to the original long URL.

## Features
  - Shorten long URLs
  - Redirect short URLs to original long URLs
  - Track number of clicks on shortened URLs
  - Display list of all shortened URLs
  
## Dependencies
This application uses the following dependencies:

  - ruby `2.7.5`
  - rails, version `5.2.8`
  - mysql2, `>= 0.4.4, < 0.6.0`

## Installation
 1. Clone the repository:
  ```
  git clone https://github.com/gulzaib-dev/url-shortener.git
 ```
 2. Navigate into the project directory:
  ```
  cd url-shortener
 ```
 3. Install the dependencies:
  ```
  bundle install
 ```
 4. Add ENVs in /.evn file:
  ```
  HOST_NAME=bath.com
  ALLOWED_CORS_ORIGINS=https://example.com,https://example.org
  ```
 5. Create the database:
  ```
   rails db:create
   rails db:migrate
 ```
 6. Seed data:
  ```
  rails db:seed
 ```
 7. Start the server:
  ```
   rails s
 ```
 8. Open your web browser and navigate to http://localhost:3000 to access the application.
 
 ## Usage
 1. Enter a long URL into the input field on the homepage and click "Shorten URL".
 2. The app will generate a shortened URL, and will redirect you to home page
 3. Click on the shortened URL to be redirected to the original long URL.
 4. The number of clicks on each shortened URL is tracked and displayed on the homepage.
 
 ## Run Test suite
  1. Navigate to url-shortener directory
  
  2. To run all Tests
   ```
     bundle exec rspec 
   ```
    
  3. To run all Url models
   ```
    bundle exec rspec spec/models
   ```
    
  4. To run all Url controllers
   ```
    bundle exec rspec spec/controllers
   ```
    
  5. To run only API Url controller 
   ```
    bundle exec rspec spec/controllers/api
   ```
