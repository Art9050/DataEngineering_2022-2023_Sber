
-- xxxx_stg_transactions
CREATE TABLE de11an.kart_stg_transactions (
	trans_id varchar(20),
	trans_date timestamp(0),
	card_num varchar(20),
	oper_type varchar(20),
	amt varchar(20),
	oper_result varchar(20),
	terminal varchar(10),
	update_dt timestamp(0)
);

-- xxxx_stg_terminals
create table de11an.kart_stg_terminals (
    terminal_id char(5),
    terminal_type char(3),
    terminal_city varchar(30),
    terminal_address varchar(200),
    update_dt timestamp(0)
);
create table de11an.kart_stg_terminals_del (
    terminal_id char(5)
);

-- xxxx_stg_blacklist
create table de11an.kart_stg_blacklist (
	passport_num varchar(20),
	entry_dt timestamp(0),
	update_dt timestamp(0)
);

-- xxxx_stg_cards
create table de11an.kart_stg_cards (
	card_num varchar(20),
	account_num varchar(25),
	create_dt timestamp(0),
	update_dt timestamp(0)
);
create table de11an.kart_stg_cards_del (
	card_num varchar(20)
);

-- xxxx_stg_accounts
create table de11an.kart_stg_accounts(
	account_num varchar(20),
	valid_to timestamp(0),
	client varchar(10),
	create_dt timestamp(0),
	update_dt timestamp(0)
);
create table de11an.kart_stg_accounts_del(
	account_num varchar(20)
);

-- xxxx_stg_clients
create table de11an.kart_stg_clients(
	client_id varchar(20),
	last_name varchar(50),
	first_name varchar(50),
	patronymic varchar(50), --patronymic в source
	date_of_birth timestamp(0),
	passport_num varchar(20),
	passport_valid_to timestamp(0),
	phone varchar(20),
	create_dt timestamp(0),
	update_dt timestamp(0)
);
create table de11an.kart_stg_clients_del(
	client_id varchar(20)
);
	
-- xxxx_dwh_fact_transactions
CREATE TABLE de11an.kart_dwh_fact_trasactions (
	trans_id varchar(20),
	trans_date timestamp(0),
	card_num varchar(20),
	oper_type varchar(20),
	amt DECIMAL,
	oper_result varchar(20),
	terminal varchar(10),
	update_dt timestamp(0)
);

-- xxxx_dwh_fact_passport_blacklist
CREATE TABLE de11an.kart_DWH_FACT_passport_blacklist (
	passport_num varchar(20),
	entry_dt timestamp(0)
);

-- xxxx_dwh_dim_terminals
create table de11an.kart_dwh_dim_terminals_hist (
    terminal_id char(5),
    terminal_type char(3),
    terminal_city varchar(30),
    terminal_address varchar(200),
    effective_from timestamp(0),
    effective_to timestamp(0),
    deleted_flg boolean
);

-- xxxx_dwh_dim_cards
create table de11an.kart_dwh_dim_cards_hist (
	card_num varchar(20),
	account_num varchar(25),
	effective_from timestamp(0),
    effective_to timestamp(0),
    deleted_flg boolean
);

-- xxxx_dwh_dim_accounts
create table de11an.kart_dwh_dim_accounts_hist(
	account_num varchar(20),
	valid_to timestamp(0),
	client varchar(10),
	effective_from timestamp(0),
    effective_to timestamp(0),
    deleted_flg boolean
);

-- xxxx_dwh_dim_clients
create table de11an.kart_dwh_dim_clients_hist(
	client_id varchar(20),
	last_name varchar(50),
	first_name varchar(50),
	patronymic varchar(50), --patronymic в source
	date_of_birth timestamp(0),
	passport_num varchar(20),
	passport_valid_to timestamp(0),
	phone varchar(20),
	effective_from timestamp(0),
    effective_to timestamp(0),
    deleted_flg boolean
);

-- xxxx_rep_fraud
create table de11an.kart_rep_fraud(
	event_dt timestamp(0),
	passport varchar(20),
	fio varchar(160),
	phone varchar(20),
	event_type char(1),
	report_dt timestamp(0)
);

create table de11an.kart_META_all(
    schema_name varchar(30),
    table_name varchar(50),
    max_update_dt timestamp(0)
);

insert into de11an.kart_META_all( schema_name, table_name, max_update_dt )
 	values( 'de11an','kart_stg_transactions', to_timestamp('1900-01-01','YYYY-MM-DD') );
	
insert into de11an.kart_META_all( schema_name, table_name, max_update_dt )
	values( 'de11an','kart_stg_terminals', to_timestamp('1900-01-01','YYYY-MM-DD') );
	
insert into de11an.kart_META_all( schema_name, table_name, max_update_dt )
	values( 'de11an','kart_stg_cards', to_timestamp('1900-01-01','YYYY-MM-DD') );	
	
insert into de11an.kart_META_all( schema_name, table_name, max_update_dt )
	values( 'de11an','kart_stg_accounts', to_timestamp('1900-01-01','YYYY-MM-DD') );
	
insert into de11an.kart_META_all( schema_name, table_name, max_update_dt )
	values( 'de11an','kart_stg_clients', to_timestamp('1900-01-01','YYYY-MM-DD') );
	
insert into de11an.kart_META_all( schema_name, table_name, max_update_dt )
	values( 'de11an','kart_stg_blacklist', to_timestamp('1900-01-01','YYYY-MM-DD') );

create table de11an.kart_dwh_rep_fraud (
	event_dt timestamp(0),
	passport varchar(20),
	fio varchar(150),
	phone varchar(20),
	event_type char(1),
	report_dt timestamp(0)
);


--drop table de11an.kart_dwh_rep_fraud;
--drop table de11an.kart_stg_transactions; 
--drop table de11an.kart_stg_terminals; 
--drop table de11an.kart_stg_terminals_del; 
--drop table de11an.kart_stg_blacklist; 
--drop table de11an.kart_stg_cards; 
--drop table de11an.kart_stg_cards_del; 
--drop table de11an.kart_stg_accounts;
--drop table de11an.kart_stg_accounts_del;
--drop table de11an.kart_stg_clients;
--drop table de11an.kart_stg_clients_del;
--drop table de11an.kart_dwh_fact_trasactions;
--drop table de11an.kart_dwh_fact_passport_blacklist; 
--drop table de11an.kart_dwh_dim_terminals_hist;
--drop table de11an.kart_dwh_dim_cards_hist;
--drop table de11an.kart_dwh_dim_accounts_hist;
--drop table de11an.kart_dwh_dim_clients_hist;
--drop table de11an.kart_rep_fraud;
--drop table de11an.kart_meta_all;