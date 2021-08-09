.. image:: image.png

Quickstart
----------

CircleCI build:

.. image:: https://circleci.com/gh/gothinkster/flask-realworld-example-app.png


First, set your app's secret key as an environment variable. For example,
add the following to ``.bashrc`` or ``.bash_profile``.

.. code-block:: bash

    export CONDUIT_SECRET='something-really-secret'

Before running shell commands, set the ``FLASK_APP`` and ``FLASK_DEBUG``
environment variables ::

    export FLASK_APP=/path/to/autoapp.py
    export FLASK_DEBUG=1

Then run the following commands to bootstrap your environment ::

    git clone https://github.com/gothinkster/flask-realworld-example-app.git
    cd flask-realworld-example-app
    pip install -r requirements/dev.txt


Run the following commands to create your app's
database tables and perform the initial migration ::

    flask db init
    flask db migrate
    flask db upgrade

To run the web application use::

    flask run --with-threads


Deployment
----------

In your production environment, make sure the ``FLASK_DEBUG`` environment
variable is unset or is set to ``0``, so that ``ProdConfig`` is used, and
set ``DATABASE_URL`` which is your postgresql URI for example
``postgresql://localhost/example`` (this is set by default in heroku).


Shell
-----

To open the interactive shell, run ::

    flask shell

By default, you will have access to the flask ``app`` and models.


Running Tests
-------------

To run all tests, run ::

    flask test


Migrations
----------

Whenever a database migration needs to be made. Run the following commands ::

    flask db migrate

This will generate a new migration script. Then run ::

    flask db upgrade

To apply the migration.

For a full migration command reference, run ``flask db --help``.

Exercice DevOps
---------------

How to build docker image ::

    docker build --tag IMAGE_NAME DOCKERFILE_PATH

How to run a container with this image ::

    docker run -p 8443:5000 IMAGE_NAME

How to pull docker image built with CI 
The image is pushed on a public Docker Hub repository : yakoi/python ::

    docker pull yakoi/python

How to generate a certificate with openssl :
1- Generate server private key and CSR ::

    openssl req -newkey rsa:4096 -keyout server-key.pem -out server-req.pem

2- Sign server private key with CA key to get back the signed certificate ::
    
    openssl x509 -req -in server-req.pem -days 60 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf
 
Optional : create a server-ext.cnf file to add DNS ::

    subjectAltName=DNS:flask-app.devops.local
    
How to run the app with https ::
    
    flask run --cert=cert.pem --key=key.pem
