# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

ruby 3.0.1

* The application can be accessed from
`http://127.0.0.1:3000/` after running `rails server`

## **Notes:**


- The steps 1,2,3,4 were taken care in this task.
- No unit tests were written
- No database migration development was required
- I had only one day (Sunday) to learn coding with ruby, and didn't have longer time, so this is my "hello world" app for me :)
- I used a MoviesService class to have a caching feature.
- Some logics were taken care of (theoretically) like re-caching when there is a new ratings inserted.
- Done features:
  
    - Display the ratings with 2 digits after the decimal point (e.g. 4.56).
    - Display the ratings count rounded down by hundrets (e.g. 2,900 instead of 2901). Values below 100 stay the same.