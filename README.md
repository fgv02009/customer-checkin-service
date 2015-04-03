# Welcome to Napa

TODO: Add an awesome README that explains how all this stuff works!

##User-Checkin Service

###A business has a code associated within that is changed daily. In order for a user to checkin a user has to know that code. However, the business is the only one who can access that code. Thus, in order for a user to checkin to a business they would have to physically be at the business and ask for the code. There are validations set up so a user can not checkin more than once a day.

###The way for a user to create a checkin is to make a post request with their email, password, the business name, and the business' daily_code.

###Every time a user checksin they receive 5 points associated with that business. A user can see their points by making a get request to users/:id/points (it requires there email and password varification)
