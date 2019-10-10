# Library Management System - LazyCoders

This is the ReadMe file for the LMS system developed by the team LazyCoders as part of the Ruby on Rails assignment in Object Oriented Design and Development. Deployment of the LMS system has been done on Heroku with Postgres database. This file contains information you might find useful while reviewing our work.  

* <strong>Heroku App Link:</strong> https://glacial-reaches-87041.herokuapp.com/

### Configuration information:

* <strong>Ruby version:</strong> 2.6.3 : <strong>Rails version:</strong> 5.2.3

* <strong>3rd-party gems used:</strong> Devise, Pundit, OAuth-Facebook

* <strong>Database used:</strong> PostgreSQL

### Pre-configured admin account details:

* Email: admin@admin.com  |  Password: 1234

### Functionalities implemented: 

* Login/Sign up for students and librarians. 

* Navigation to any page is disabled without log in and no user can see the information of any other user

* Proper authorization for CRUD actions has been done, as in Student cannot delete a book, etc.

* Basic CRUD operations for entities involved, i.e. Student, Librarian, Books, Library

* Search through books by title, author, publication date, subject

* Edit profile enabled for students, librarians

### Functionalities not implemented (Working on it): 

* Librarian needs to be approved by admin after account creation

* Check out, return, reserve, bookmark books and receive email when book request is successful

* View fines and borrowing history
