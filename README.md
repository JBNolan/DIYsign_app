# SoleMate

## Description

Heroku Link: https://diysign.herokuapp.com/

DIYsign is a site where users can view, post, and browse detailed step-by-step instructions of DIY projects. DIYsign is a Ruby on Rails app, with some React components built in for a better UX. The app utilizes the Google Places API, PostgreSQL database, Foundation front end with custom CSS, CarrierWave for photo uploading, and Devise for user authentication.

## Features

* Creating and signing into a user account
* Adding projects to the database
* Adding project steps to the database
* Adding comments for a project
* Upvoting/downvoting project comments
* Viewing other user profiles
* Filtering projects by category
* Viewing closest relevant stores based on user's zip code

## Technologies

* Ruby on Rails
* ReactJS
* PostgreSQL
* Foundation
* CarrierWave
* Devise
* HTTParty
* Geocoder
* S3
* AWS
* Heroku

## Local Setup

```
git clone https://github.com/JBNolan/DIYsign_app.git
cd DIYsign_app
bundle install
npm install
rake db:create && rake db:migrate
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JBNolan/DIYsign_app.git. Use the [fork-and-branch](http://blog.scottlowe.org/2015/01/27/using-fork-branch-git-workflow/) workflow to contribute.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
