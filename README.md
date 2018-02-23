# NAME

Pg::ServiceFile - Basic PostgreSQL connection service file interface

# SYNOPSIS

    use Pg::ServiceFile;

    # Uses $ENV{PGSERVICEFILE} or user's `~/.pg_service.conf` file
    my $pgservice = Pg::ServiceFile->new();

    # Use a specific service file - `pg_config --sysconfdir`/pg_service.conf
    my $pgservice = Pg::ServiceFile->new(file => '/etc/postgresql-common/pg_service.conf');

    # Print all the service names
    say $_ for @{$pgservice->names};

    # Get the username for a specific service name
    say $pgservice->services->{foo}->{user};

# DESCRIPTION

[Pg::ServiceFile](https://metacpan.org/pod/Pg::ServiceFile) is a partially complete interface to the PostgreSQL
connection service file. It's complete in the fact that it reads the `$ENV{PGSERVICEFILE}` or user service file as standard, but will not
automatically retrieve and merge the system-wide service file or check
`PGSYSCONFDIR`.

# ATTRIBUTES

[Pg::ServiceFile](https://metacpan.org/pod/Pg::ServiceFile) implements the following attributes.

## data

    my $pgservice = Pg::ServiceFile->new(data => <<~'PGSERVICEFILE');
        [foo]
        host=localhost
        port=5432
        user=foo
        dbname=db_foo
        password=password
    PGSERVICEFILE

    my $pgservice = Pg::ServiceFile->new(file => '~/.pg_service.conf');
    say $pgservice->data;

The connection service file data. This is the contents of ["file"](#file), or the
data that has been passed in directly during instantiation.

## file

    my $pgservice = Pg::ServiceFile->new();
    say $pgservice->file; # ~/.pg_service.conf (if it exists)

    my $pgservice = Pg::ServiceFile->new(file => '~/myservice.conf');
    say $pgservice->file; # ~/myservice.conf

Defaults to `$ENV{PGSERVICEFILE}` or `~/.pg_service.conf`, but can be
any valid connection service file.

## name

    local $ENV{PGSERVICE} = 'foo';

    my $pgservice = Pg::ServiceFile->new();
    say $pgservice->name; # foo
    say $pgservice->service->{dbname}; # db_foo

The value of `$ENV{PGSERVICE}` if it exists, or whatever is set during
instantiation. It does not check to see if a corresponding service entry exists
in the service ["file"](#file), but ["service"](#service) will return the relevant data if
it does.

## names

    my $pgservice = Pg::ServiceFile->new();
    say $_ for @{$pgservice->names};

Returns the names of all the connection services from the service ["file"](#file).

## service

If ["name"](#name) has been set via `$ENV{PGSERVICE}` or on instantiation, returns
the corresponding connection service.

## services

    my $pgservice = Pg::ServiceFile->new();
    for my $service ($pgservice->services) {
        say "$service->{dbname} at $service->{host}";
    }

Returns a `HASH` of all of the connection services from ["file"](#file).

# AUTHOR

Paul Williams <kwakwa@cpan.org>

# COPYRIGHT

Copyright 2018- Paul Williams

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[https://www.postgresql.org/docs/current/static/libpq-pgservice.html](https://www.postgresql.org/docs/current/static/libpq-pgservice.html).
