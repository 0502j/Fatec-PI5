create table registroemail(
    id serial not null,
    "email_to" varchar(255) not null,
    subject varchar(100),
    message text,
    "date_sent" timestamptz,
    status varchar(100),
    primary key(id)
);