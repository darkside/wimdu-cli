# Wimdu coding challenge

On wimdu.com, people can list their place to rent out. Wouldn't it be
great if there was a more nerdy way to enter your data? How about a
CLI?

## The task

Build a standalone app that allows users to list their place via a
CLI. For the sake of simplicity, the data is kept locally. Similar to
the web app it should be possible to enter partial data and continue
later. However, make sure that in the end all required data is
present. Only when all data is present the newly created property
should appear in the list of all properties.

* Allow users to create new properties from the command line
* Prompt for attributes, validate the input
* When the data entry is interrupted, provide a way to resume entering data
* Store the property in some local storage; make sure no invalid data
  is stored
* Every property has the following attributes
  * title
  * property type, which is one of
    * holiday home
    * apartment
    * private room
  * address
  * nightly rate in EUR
  * max guests
  * email
  * phone number 

An example session could look like this:

    $ wimdu list
    No properties found.

    $ wimdu new
    Starting with new property ABC1DEF2.

    Title: Amazing room at Wimdu Office
    Address: ^C

    $ wimdu list
    No offers found.

    $ wimdu continue ABC1DEF2
    Continuing with ABC1DEF2

    Address: Voltastr. 5, 13355 Berlin
    Nightly rate in EUR: 12
    Max guests: Two

    Error: must be a number

    Max guests: 2
    ^C
    $ wimdu continue ABC1DEF2
    Continuing with ABC1DEF2

    Email: foo@example.com
    Phone number: +1 555 2368

    Great job! Listing ABC1DEF2 is complete!

    $ wimdu list
    Found 1 offer.

    ABC1DEF2: Amazing Room at Wimdu Office

## Hints

It's totally fine to use 3rd party libraries like ruby's gems. You're
free to choose your storage mechanism/database. Just use the right
tool for the job.

It would be nice if you could send your results as a
repository. Either put it online or if you'd rather not have it be
public send it e.g. as a git bundle. Here's how to do that:

    $ git bundle create jane-schmoe-wimdu-cli.bundle master

Just to check if stuff worked, you can clone from this file with

    $ git clone -b master jane-schmoe-wimdu-cli.bundle

Mercurial also has a bundle feature. If you use any other version
control system we'd appreciate instructions on how to recreate the
repo.

Happy hacking!
