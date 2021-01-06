# Table of Contents

- [Table of Contents](#table-of-contents)
- [Useful Commands](#useful-commands)
  - [Unix file permissions](#unix-file-permissions)
  - [Bash](#bash)
    - [Bash program control](#bash-program-control)
    - [Bash Piping](#bash-piping)
    - [Rsync](#rsync)
  - [Pytest](#pytest)
    - [SQLAlchemy Rollback changes made in a test](#sqlalchemy-rollback-changes-made-in-a-test)
    - [Session setup and teardown](#session-setup-and-teardown)
  - [AWS](#aws)
    - [AWS update stack command line](#aws-update-stack-command-line)
    - [AWS Create EC2 spot instances](#aws-create-ec2-spot-instances)
  - [VIM](#vim)
    - [Jump to previous location `CTR-O`](#jump-to-previous-location-ctr-o)
    - [Past Register in insert and command mode `CTR-R`](#past-register-in-insert-and-command-mode-ctr-r)
    - [norm command](#norm-command)
    - [Digrams](#digrams)
  - [Python](#python)
    - [SQLAlchemy](#sqlalchemy)
  - [Docker Notes](#docker-notes)
    - [Quicker Builds](#quicker-builds)
    - [Docker Compose](#docker-compose)
    - [Docker EntryPoint and CMD](#docker-entrypoint-and-cmd)
    - [docker run](#docker-run)
  - [Postgres](#postgres)
  - [OSX Tricks](#osx-tricks)
    - [Spotlight Searches](#spotlight-searches)
    - [Reset OSX spotlight index (fixes search problems.)](#reset-osx-spotlight-index-fixes-search-problems)
    - [Screen shots](#screen-shots)
  - [GIT](#git)
    - [Searching history](#searching-history)
    - [Git Filter magic](#git-filter-magic)


# Useful Commands

## Unix file permissions

```bash
chmod perm file # change file permissions
chown own file # Change file owner
chgrp grp file # change file group
```

chmod values:

| Value | Premission |
| :---- | ---------: |
| 1     |    Execute |
| 2     |      Write |
| 4     |       read |



## Bash


### Bash program control

1.  Backgrounding Processes

        CTRL-Z # background process (pauses it)
        fg # bring process to forground
        bg # starts process running in background
        disown # disowns a process from terminal (it'll keep running if the terminal is closed)
        jobs # lists processes owned by terminal
        kill %jobnumber # kills job

    fb and bg can take a job number if there are multiple

2.  finding process after being disowned.

    ps lists running processes use grep to search

        # finds all jupyter instances running as the current user
        ps | grep jupyter

        # finds all jupyter instances regardless of users
        ps -e | grep jupyter

        # kill will kill the process id
        kill $id




### Bash Piping

pv monitors a data transfer kinda sweet.

```bash
    cat file | pv | other_command
```

pv will have a progress bar for the cat.


### Rsync

```bash
# Sync with a remote folder
rsync -avz <remote-machine>/path/to/files/ /path/to/local/folder
```


## Pytest

### SQLAlchemy Rollback changes made in a test

Below doesn't work if the tests require rollbacks. There is a more
complicated [example](http://docs.sqlalchemy.org/en/latest/orm/session_transaction.html) which can handle that case.

```python
    from sqlalchemy.orm import sessionmaker
    from sqlalchemy import create_engine
    from unittest import TestCase

    # global application scope.  create Session class, engine
    Session = sessionmaker()

    engine = create_engine('postgresql://...')

    class SomeTest(TestCase):
        def setUp(self):
            # connect to the database
            self.connection = engine.connect()

            # begin a non-ORM transaction
            self.trans = self.connection.begin()

            # bind an individual Session to the connection
            self.session = Session(bind=self.connection)

        def test_something(self):
            # use the session in tests.

            self.session.add(Foo())
            self.session.commit()

        def tearDown(self):
            self.session.close()

            # rollback - everything that happened with the
            # Session above (including calls to commit())
            # is rolled back.
            self.trans.rollback()

            # return connection to the Engine
            self.connection.close()
```

### Session setup and teardown

An example that creates and destroys database tables for tests.

```python
    @pytest.fixture(scope='session', autouse=True)
    def setup_db(request):
        """Setup the DB and drop tables after tests are run."""

        # Create tables
        db.Base.metadata.create_all(engine)

        def teardown():
            db.Base.metadata.drop_all(engine)

        # Ensure tables are dropped at the end of testing
        request.addfinalizer(teardown)
```

`finalizer` will always get called. This can be used for tear-downs in
other scopes as well.




## AWS

### AWS update stack command line

```sh
    aws cloudformation update-stack --stack-name msgan --template-body "$(cat ms-gan-cf.yaml)"
```

If you are creating policies or IAM users you have to specify

```sh
    --capabilities "CAPABILITY_NAMED_IAM"
```

ec2 instances are just restarted on update, and wont rerun script. To
force a new instance it's easiest to just change the size by one unit
and rerun the update. Hackish but works. For bastion it's easiest to
just go between nano and micro.

Okay the above restarts the instance but the script isn't always updating which is weird.

### AWS Create EC2 spot instances

Spot instance

```sh
    request-spot-instances
    [--availability-zone-group <value>]
    [--block-duration-minutes <value>]
    [--client-token <value>]
    [--dry-run | --no-dry-run]
    [--instance-count <value>]
    [--launch-group <value>]
    [--launch-specification <value>]
    [--spot-price <value>]
    [--type <value>]
    [--valid-from <value>]
    [--valid-until <value>]
    [--instance-interruption-behavior <value>]
    [--cli-input-json <value>]
    [--generate-cli-skeleton <value>]
```

Basic command for starting an instance in our GPU environment. A
persistent spot request restarts after it's terminated. You can also
tell the instance that you don't want to destroy the instance.

```sh
    aws ec2 request-spot-instances --launch-specification $(cat gpu_spec.json) --instance-nterruption-behavior "stop" --type "persistant"
```

An example configuration json.

```json
    {
        "DryRun": true,
        "ImageId": "ami-dfc39aef",
        "KeyName": "mykey",
        "SecurityGroups": [
            "my-sg"
        ],
        "InstanceType": "t2.micro",
        "Monitoring": {
            "Enabled": true
        }
    }
```



## VIM


### Jump to previous location `CTR-O`

### Past Register in insert and command mode `CTR-R`

### norm command

norm can be used to apply a macro to multiple lines

`:<','>norm@a`

can also be used to apply a macro to lines that match a command

`:g/pattern/norm@a` which is pretty clutch

### Digrams

You can use vim to insert special characters as two character combos. In insert
mode

`ctrl-k <letter1><letter2>`

Most greek letters are their roman alphabet pre/post fixed with `*`.

`ctrl-k p*` produces π

Some useful digrams.

| Key Combo  | Result |
| :--------- | -----: |
| `ctrl-k p* |      π |
| `ctrl-k P* |      Π |
| `ctrl-k e* |      ε |
| `ctrl-k n* |      ν |
| `ctrl-k TE |      ∃ |
| `ctrl-k OR |      ∨ |
| `ctrl-k AN |      ∧ |
| `ctrl-k O/ |      Ø |
| `ctrl-k FA |      ∀ |


## Python


### SQLAlchemy

[Relationships](http://docs.sqlalchemy.org/en/latest/orm/basic_relationships.html)

.has lets you reference relationships


## Docker Notes

Docker has some interesting quirks: here are some of the things that
I've found helpful.

### Quicker Builds

Docker uses cashes. For quicker builds the `requirements.txt` should be
loaded first and then pip installed. The code directory can then be
added to the build afterwords. This ensures that python packages are
reinstalled only when the requirements file gets updated.
```docker

    WORKDIR /app

    ADD ./requirements.txt /app/requirements.txt

    # Install python packages
    RUN pip install --trusted-host pypi.python.org -r requirements.txt
    # Copy Current Directory to docker
    ADD . /app
```

If the `ADD . /app` line was before the pip install line, every-time
the code changes pip install would be run.

### Docker Compose

Docker Compose makes it easy to run multiple dockers connect them for
networking.

In the docker compose file the name of each docker will be used in
networking, i.e. in the compose file bellow. You can use the host name
postgres to connect to the database from the puller file.

```yaml
    version: '3'
    services:
      puller:
        build: .
        volumes:
          - .:/testing
        tty: true
        entrypoint: "/bin/bash"
      postgres:
        image: postgres
        restart: always
        links:
          - puller
        ports:
          - "5432:5432"
        environment:
          POSTGRES_USER: 'tableau'
          POSTGRES_PASSWORD: 'tableau'
```

The other thing is you can override the docker file and do things like
run a tty terminal and change the entry-point. This is useful for
setting up testing environments when you want to go in and run things
manually.

If you want to connect to a instance after running docker-compose up

```sh
    docker-compose exec $name $command
```
Works. You can use this to run bash and connect to the docker instance.


### Docker EntryPoint and CMD

Use both when you want to specify default arguments
CMD will be run if there are no arguments otherwise it will get
overridden. Kinda useful.


### docker run

everything after the docker image get's passed on to the docker
image. Therefore you have to specify flags before the docker image
name.

```sh
    # this does not work
    docker run <docker_image> -v /path/:/path/

    # This does
    docker -v /path:/path/ <docker_image>
```

## Postgres

```sql
    GRANT ALL PRIVILEGES ON MY_SCHEMA TO MY_USER;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA MY_SCHEMA TO MY_GROUP;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA MY_SCHEMA TO MY_GROUP;
```

The above works on things that are already created. You have to change
the defaults to grant privalges on tables that are created later.

```sql
    ALTER DEFAULT PRIVILEGES IN SCHEMA MY_SCHEMA
      GRANT ALL PRIVILEGES ON TABLES TO MY_GROUP;

    ALTER DEFAULT PRIVILEGES IN SCHEMA MY_SCHEMA
      GRANT ALL PRIVILEGES ON SEQUENCES TO MY_GROUP;
```

Some postgres commands:

-   `\q` quit
-   `\dp+ table_name` list object and privileges

## OSX Tricks

### Spotlight Searches

Spotlight searches (which is what outlook uses) can take Boolean operators.
`OR, AND, and NOT`

You can also filter on the following list of keywords:
- from
- to
- author
- with
- by
- tag
- title
- name
- keyword
- contains

you can also specify kind: allowable kinds are:
- apps (app, application, applications)
- contact
- folder
- email
- event
- reminder
- image
- movies
- music
- audio
- pdf
- preferences
- bookmark
- font
- presentation


### Reset OSX spotlight index (fixes search problems.)

```bash
sudo mdutil -E /
```


### Screen shots

-   `Command-Shift-4` Screen shot of selection (space switches to window)
-   `Command-Shift-3` Screen shot
-   `Ctr+` modifies the above commands to copy to clipboard instead of desktop.

Note the screenshot application can change the save location of the default location.
`Command-Shift-{3,4}` is to the default location. This can cause confusion.

## GIT

### Searching history

Some useful tools for searching the history and commits.

```sh
    # This greps all files for a regex in all commits!
    git grep <regexp> $(git rev-list --all)

    # Search the commit messages
    git log --all --notes --grep=<regex>

    # Search the authors
    git log -all --author=<regex>

    # Both take the -i flag to ignore case, and can handle regex
```
### Git Filter magic

```sh
    # Search for a string using sed and find and repace
    git filter-branch --tree-filter "find . -type f -exec sed -i -e 's/originalpassword/newpassword/g' {} \;"

    # Delete all lines containing a word
    git filter-branch --tree-filter "find . --type f -exec sed -i -e '/$*word/d' {} \;"

    # Filtering authors and emails
    git filter-branch --env-filter '
    OLD_EMAIL="your-old-email@example.com"
    CORRECT_NAME="Your Correct Name"
    CORRECT_EMAIL="your-correct-email@example.com"
    if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_COMMITTER_NAME="$CORRECT_NAME"
        export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
    ' --tag-name-filter cat -- --branches --tags

    # Filtering commit messages
    git filter-branch --msg-filter 'sed "s/old/new/g'
```

Notes that if the refs exist in origin or in the reflog they're still
show up in the search.


