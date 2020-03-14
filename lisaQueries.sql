SELECT TABLE_NAME,SUM(TABLE_ROWS)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'cr09_lisa_scelli_delivery'
GROUP BY TABLE_NAME;
--how much rows in each table
--contact
--9
--customer
--6
--department
--4
--description
--6
--employee
--4
--firm_info
--3
--location
--4
--mail
--12
--processing_system
--3
--send_receive
--16


SELECT COUNT(*) FROM employee
WHERE hire_date
BETWEEN "2019-01-01 00:00:01" and "2020-03-14 00:00:01";

--2

SELECT employee.first_name, employee.last_name FROM employee
WHERE hire_date
BETWEEN "2019-01-01 00:00:01" and "2020-03-14 00:00:01";

--valeria ignaz and nadine abou-zid

SELECT description.mail_category, description.content_category , mail.date_sent, mail.date_received
FROM description
INNER JOIN mail on mail.fk_description_id = description.description_id;

--what has been sent, when sent and when received


SELECT description.mail_category, description.content_category , mail.date_sent, customer.first_name, customer.last_name
FROM description
INNER JOIN mail on mail.fk_description_id = description.description_id
INNER JOIN customer on mail.fk_sender_id = customer.customer_id

--who sent what and when


SELECT mail.mail_id, description.mail_category, description.content_category , customer.first_name, customer.last_name, mail.date_sent
FROM description
INNER JOIN mail on mail.fk_description_id = description.description_id
INNER JOIN customer on mail.fk_sender_id = customer.customer_id;

SELECT mail.mail_id, description.mail_category, description.content_category, customer.first_name, customer.last_name, mail.date_received
FROM description
INNER JOIN mail on mail.fk_description_id = description.description_id
INNER JOIN customer on mail.fk_receiver_id = customer.customer_id;

--1 table shows who sent what and when
--2d table shows who got what and when

SELECT employee.last_name
FROM employee
WHERE employee.hire_date > "2000-11-01"
AND employee.fk_department_id
    IN (SELECT department.department_id
        FROM department
        WHERE department.dep_name = "delivery" );

--who was hired after 2000 and works in the delivery department

SELECT COUNT(mail.mail_id) FROM mail
INNER JOIN customer on mail.fk_receiver_id = customer.customer_id
INNER JOIN contact on customer.fk_contact_id = contact.contact_id
INNER JOIN send_receive on customer.customer_id = send_receive.fk_receiver_id
INNER JOIN employee on send_receive.fk_employee_id = employee.employee_id
WHERE contact.country = "AT";

--how much mails have been received in austria and directly delivered to customer and from which employee



SELECT COUNT(mail.mail_id) FROM mail
INNER JOIN customer on mail.fk_receiver_id = customer.customer_id
INNER JOIN contact on customer.fk_contact_id = contact.contact_id
INNER JOIN send_receive on customer.customer_id = send_receive.fk_receiver_id
INNER JOIN employee on send_receive.fk_employee_id = employee.employee_id
AND employee.first_name = "valeria"
WHERE contact.country = "AT";
/*how much mails have been received in austria and directly delivered to customer and from employee named valeria*/





SELECT description.content_category as what_s_in, customer.first_name as receiver, employee.first_name as delivered_from
FROM (mail
INNER JOIN description on mail.fk_description_id = description.description_id
INNER JOIN customer on mail.fk_receiver_id = customer.customer_id
INNER JOIN contact on customer.fk_contact_id = contact.contact_id
INNER JOIN send_receive on mail.mail_id = send_receive.fk_mail_id
INNER JOIN employee on send_receive.fk_employee_id = employee.employee_id)

WHERE contact.city = "Paris"
/*what content category of mails have been received in Paris and from which employee delivered*/

--creation

CREATE TABLE if not exists department (
	department_id int AUTO_INCREMENT PRIMARY KEY,
    dep_name varchar(50) not null,
    dep_nb tinyint(20) not null unique key
);

CREATE TABLE if not exists description(
	description_id int AUTO_INCREMENT PRIMARY KEY,
    customs_nb int(50) not null,
    mail_category ENUM("letter", "package") default "letter",
    content_category varchar(80)
);

CREATE TABLE if not exists contact(
	contact_id int AUTO_INCREMENT PRIMARY KEY,
    house_nb tinyint(8) not null,
    street varchar(80) not null,
    city varchar(80)not null,
    ZIP int(5)not null,
    country varchar(3) not null DEFAULT "AT"
);

CREATE TABLE if not exists firm_info(
	firm_info_id int AUTO_INCREMENT PRIMARY KEY,
    corporate_form varchar(15) not null DEFAULT "GmbH",
    commercial_registration varchar(25)not null,
    VAT_nb int(25)not null
);

CREATE TABLE if not exists customer(
	customer_id int AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(50) not null,
    last_name varchar(50)not null,
    tel bigint not null,
    fk_contact_id int not null,
    FOREIGN KEY (fk_contact_id) REFERENCES contact(contact_id)
);

CREATE TABLE if not exists location(
	location_id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) not null,
    fk_contact_id int not null,
    FOREIGN KEY (fk_contact_id) REFERENCES contact(contact_id),
    fk_firm_info_id int not null,
    FOREIGN KEY (fk_firm_info_id) REFERENCES firm_info(firm_info_id)
);

CREATE TABLE if not exists processing_system(
	processing_system_id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) not null,
    capacity_package int,
    fk_contact_id int not null,
    FOREIGN KEY (fk_contact_id) REFERENCES contact(contact_id),
    fk_firm_info_id int not null,
    FOREIGN KEY (fk_firm_info_id) REFERENCES firm_info(firm_info_id)
);

CREATE TABLE if not exists employee(
	employee_id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) not null,
    first_name varchar(50) not null,
    last_name varchar(50)not null,
    bithdate date NOT null,
    hire_date date not null,
    fk_contact_id int not null,
    FOREIGN KEY (fk_contact_id) REFERENCES contact(contact_id),
    fk_department_id int not null,
    FOREIGN KEY (fk_department_id) REFERENCES department(department_id),
    fk_processing_system_id int not null,
    FOREIGN KEY (fk_processing_system_id) REFERENCES processing_system(processing_system_id)
);

CREATE TABLE if not exists mail(
	mail_id int AUTO_INCREMENT PRIMARY KEY,
    weight_gr int not null DEFAULT "30",
    date_sent timestamp not null,
    date_received timestamp not null,
    fk_description_id int not null,
    FOREIGN KEY (fk_description_id) REFERENCES description(description_id),
    fk_location_id int not null,
    FOREIGN KEY (fk_location_id) REFERENCES location(location_id),
    fk_sender_id int not null,
    FOREIGN KEY (fk_sender_id) REFERENCES customer(customer_id),
    fk_receiver_id int not null,
    FOREIGN KEY (fk_receiver_id) REFERENCES customer(customer_id)
);

CREATE TABLE if not exists send_receive(
	send_receive_id int AUTO_INCREMENT PRIMARY KEY,
    status ENUM("received", "sent") default "received",
    fk_location_id int,
    FOREIGN KEY (fk_location_id) REFERENCES location(location_id),
    fk_processing_system_id int,
    FOREIGN KEY (fk_processing_system_id) REFERENCES processing_system(processing_system_id),
    fk_receiver_id int,
    FOREIGN KEY (fk_receiver_id) REFERENCES customer(customer_id),
    fk_mail_id int not null,
    FOREIGN KEY (fk_mail_id) REFERENCES mail(mail_id),
    fk_employee_id int not null,
    FOREIGN KEY (fk_employee_id) REFERENCES employee(employee_id)
);
