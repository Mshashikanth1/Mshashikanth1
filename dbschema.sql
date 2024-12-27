create table media_entity
(
    media_id           bigint auto_increment
        primary key,
    media_type         tinyint                            null,
    media_url          varchar(255)                       null,
    media_size_byte    bigint                             null,
    created_by         varchar(255)                       not null,
    created_date       datetime default CURRENT_TIMESTAMP not null,
    last_modified_date datetime                           null on update CURRENT_TIMESTAMP,
    last_modified_by   varchar(255)                       null
);

create table otp_entity
(
    otp_session_id     varchar(255)                       not null
        primary key,
    otp_value          bigint                             null,
    generated_count    bigint                             null,
    created_by         varchar(255)                       not null,
    created_date       datetime default CURRENT_TIMESTAMP not null,
    last_modified_date datetime                           null on update CURRENT_TIMESTAMP,
    last_modified_by   varchar(255)                       null,
    otp_client_id      varchar(255)                       null,
    otp_client_type    tinyint                            null,
    otp_expiry         datetime                           not null
);

create table user_entity
(
    user_id              bigint auto_increment
        primary key,
    display_name         varchar(255)                       null,
    first_name           varchar(255)                       not null,
    last_name            varchar(255)                       not null,
    mobile_number        varchar(255)                       null,
    created_by           varchar(255)                       not null,
    created_date         datetime default CURRENT_TIMESTAMP not null,
    last_modified_date   datetime                           null on update CURRENT_TIMESTAMP,
    last_modified_by     varchar(255)                       null,
    display_pic_media_id bigint                             null,
    constraint mobile_number_unique
        unique (mobile_number),
    constraint user_entity_media_entity_media_id_fk
        foreign key (display_pic_media_id) references media_entity (media_id)
);

create table shop_entity
(
    shop_id            bigint auto_increment
        primary key,
    user_id            bigint       not null,
    shop_name          varchar(255) null,
    shop_description   varchar(255) null,
    created_date       datetime(6)  null,
    last_modified_date datetime(6)  null,
    created_by         varchar(255) null,
    last_modified_by   varchar(255) null,
    constraint shop_entity_user_entity_user_id_fk
        foreign key (user_id) references user_entity (user_id)
);

create index fk_shop_user_idx
    on shop_entity (user_id);

create table working_entry_entity
(
    working_entry_id bigint                             not null
        primary key,
    start_time       time                               null,
    end_time         time                               null,
    working_date     date                               null,
    shop_id          bigint                             not null,
    notes            text                               null,
    when_created     datetime default CURRENT_TIMESTAMP null,
    when_updated     datetime default CURRENT_TIMESTAMP null
);

create index fk_working_entry_shop_idx
    on working_entry_entity (shop_id);
