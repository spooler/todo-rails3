Todo App
========

This is a sample app for beginners to learn how to build a TODO app in Rails 3


Requirements
------------

* Ability to list, create, modify and remove users (attributes: email and password)
* Users can list, create, modify and remove his own lists.
* A list can contain one or more text-only items.
* It must be a RESTful service.
* It must include tests.


Decisions
----------

* I decided to use jQuery instead of Prototype because jQ is significantly better from my point of view.
* I decided to use the gem Devise for the users authentication because I didn't want to spend too much time doing manually these stuff.
* I decided to use Haml and Sass, so that this app serves too as a sample for these ways to generate HTML and CSS code respectively.


Notes
-----

* Tasks still lack a feature to update the status. I may be adding it in the coming days.

