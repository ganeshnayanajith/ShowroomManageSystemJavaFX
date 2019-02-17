CREATE DATABASE crowndb

CREATE TABLE supplier
(
	supplier_id VARCHAR(10),
    supplier_name VARCHAR(20),
    telephone VARCHAR(20),
    email VARCHAR(30),
    address VARCHAR(50),
    
    CONSTRAINT supplier_pk PRIMARY KEY (supplier_id)
);

/*INSERT INTO supplier VALUES('S23', 'Samsung', '3233', 'samsung@gmail.com' , 'DC' );*/
/*SELECT * FROM  supplier*/
/*time format "19:30:10" */

CREATE TABLE supplier_order
(
	order_id VARCHAR(10),
    order_date date,
    order_time time,
    total double,
    supplier_id VARCHAR(50), 
    
    CONSTRAINT supplier_order_pk PRIMARY KEY (order_id),
    CONSTRAINT supplier_order_fk1 FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id) ON UPDATE CASCADE ON DELETE SET NULL
);


/*
SELECT * FROM supplier_order
INSERT INTO supplier_order VALUES( 'O334', '2018-11-11', '19:30:10', 35000, 'S23' );
*/ 

CREATE TABLE supplier_payment
(
	payment_id VARCHAR(10),
    type VARCHAR(20),
    amount double,
	payment_date date,
    payment_time time,
    order_id VARCHAR(10),
    
    CONSTRAINT supplier_payment_pk PRIMARY KEY (payment_id),
    CONSTRAINT supplier_payment_fk FOREIGN KEY (order_id) REFERENCES supplier_order(order_id) ON DELETE SET NULL
);


CREATE TABLE item
(
	item_code VARCHAR(20),
    model_name VARCHAR(20),
    item_condition VARCHAR(20),
    order_id VARCHAR(10),
    category_name VARCHAR(20),
    
    CONSTRAINT item_pk PRIMARY KEY(item_code),
    CONSTRAINT item_fk1 FOREIGN KEY(model_name) REFERENCES model(model_name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE brand_new_item
(
	item_code VARCHAR(20),
    sale_price DOUBLE, 
    
    CONSTRAINT brand_new_item_pk PRIMARY KEY( item_code),
    CONSTRAINT brand_new_item_fk1 FOREIGN KEY(item_code) REFERENCES item(item_code) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE repair_item
(
	item_code VARCHAR(20),
    cost DOUBLE,
    cust_id VARCHAR(10),
    emp_id VARCHAR(10),
    payment_id VARCHAR(10) DEFAULT NULL,
    
    CONSTRAINT repair_item_pk PRIMARY KEY(item_code),
    CONSTRAINT repair_item_fk1 FOREIGN KEY(item_code) REFERENCES item(item_code) ON UPDATE CASCADE ON  DELETE CASCADE, 
    CONSTRAINT repair_item_fk2 FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT repair_item_fk3 FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT reapir_item_fk4 FOREIGN KEY(payment_id) REFERENCES customer_payment(payment_id) ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE repair_detail
(
	repair_detail_id VARCHAR(10),
    repair_date date,
    description VARCHAR(200),
    item_code VARCHAR(20),
    
    CONSTRAINT repair_detail_pk PRIMARY KEY(repair_detail_id),
    CONSTRAINT item_detail_fk1 FOREIGN KEY(item_code) REFERENCES repair_item(item_code) ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE model
(
	model_name VARCHAR(20),
    unit_price DOUBLE, 
    quantity INT,
    supplier_id VARCHAR(10),
    
    CONSTRAINT model_pk PRIMARY KEY(model_name),
    CONSTRAINT model_fk1 FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE supplier_order_return
(
	return_id VARCHAR(10),
    quantity INT,
    payback_price DOUBLE,
    order_id VARCHAR(10),
    
    CONSTRAINT supplier_order_return_pk PRIMARY KEY(return_id),
    CONSTRAINT supplier_order_return_fk1 FOREIGN KEY( order_id ) REFERENCES supplier_order(order_id) ON DELETE SET NULL 
);

CREATE TABLE cart
(
	cart_id VARCHAR(10),
    price DOUBLE,
    quantity INT,
    cust_id VARCHAR(10),
    item_code VARCHAR(20),
    
    CONSTRAINT cart_pk1 PRIMARY KEY(cart_id,item_code),
    CONSTRAINT cart_fk1 FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT cart_fk2 FOREIGN KEY(item_code) REFERENCES brand_new_item(item_code) ON DELETE CASCADE ON  UPDATE CASCADE 
);

CREATE TABLE customer_order
(
	order_id VARCHAR(10),
    cart_id VARCHAR(10),
    order_date date,
    order_time time,
    total DOUBLE,
    delivery_id VARCHAR(10) DEFAULT NULL, 
    
    CONSTRAINT customer_order_pk PRIMARY KEY(order_id),
    CONSTRAINT customer_order_fk1 FOREIGN KEY(cart_id) REFERENCES cart(cart_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT customer_order_fk2 FOREIGN KEY(delivery_id) REFERENCES delivery(delivery_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE customer_payment
(
	payment_id VARCHAR(10),
    payment_date date,
    payment_time time,
    amount DOUBLE,
    payment_type VARCHAR(20),
    order_id VARCHAR(10),
    
    CONSTRAINT customer_payment_pk PRIMARY KEY(payment_id),
    CONSTRAINT customer_payment_fk1 FOREIGN KEY(order_id) REFERENCES customer_order(order_id) ON DELETE SET NULL ON UPDATE CASCADE 
	
);

CREATE TABLE customer
(
	cust_id VARCHAR(10),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    NIC varchar(10),
    emai varchar(30),
    contact_no VARCHAR(10),
    address VARCHAR(50),
    
    CONSTRAINT customer_pk PRIMARY KEY(cust_id)
);

CREATE TABLE customer_complain
(
	complain_id VARCHAR(10),
    description VARCHAR(200),
    complain_date date,
    complain_time time,
    cust_id VARCHAR(10),
    
    CONSTRAINT customer_complain_pk PRIMARY KEY(complain_id),
    CONSTRAINT costomer_complain_fk1 FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON  UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE employee
(
	emp_id VARCHAR(10),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    NIC VARCHAR(10),
    address VARCHAR(50),
    email VARCHAR(30),
    contact_no VARCHAR(10),
    
    CONSTRAINT employee_pk PRIMARY KEY(emp_id)
);

CREATE TABLE employee_attendance
(
	attendance_date date,
    attendance_time time,
    emp_id VARCHAR(10),
    
    CONSTRAINT employee_attendance_pk PRIMARY KEY(attendance_date),
    CONSTRAINT employee_attendance_fk1 FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE salary
(
	salary_id VARCHAR(10),
    allowance DOUBLE, 
    OT_rate DOUBLE,
    deduction DOUBLE,
    basic_salary DOUBLE,
    emp_id VARCHAR(10),
    
    CONSTRAINT salary_pk PRIMARY KEY(salary_id),
    CONSTRAINT salary_fk1 FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON UPDATE CASCADE ON DELETE CASCADE 
);

select * from employee;
select * from salary;
select * from delivery_expense;

CREATE TABLE system_user
(
	user_id VARCHAR(10),
    username VARCHAR(20),
    password VARCHAR(50),
    type VARCHAR(20),
    emp_id VARCHAR(10),
    
    
    CONSTRAINT system_user_pk PRIMARY KEY (user_id),
    CONSTRAINT system_user_fk1 FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE delivery
(
	delivery_id VARCHAR(10),
    address VARCHAR(50),
    delivery_date date,
    vehicle_id VARCHAR(10),
    
    CONSTRAINT delivery_pk PRIMARY KEY(delivery_id),
    CONSTRAINT delivery_fk1 FOREIGN KEY(vehicle_id) REFERENCES vehicle(vehicle_id)  ON  DELETE SET NULL ON UPDATE CASCADE 
);

CREATE TABLE delivery_employee
(
	delivery_id VARCHAR(10),
    emp_id VARCHAR(10),
    
    CONSTRAINT delivery_employee_pk PRIMARY KEY(delivery_id, emp_id ),
    CONSTRAINT delivery_employee_fk1 FOREIGN KEY(delivery_id) REFERENCES delivery(delivery_id), 
    CONSTRAINT delivery_employee_fk2 FOREIGN KEY(emp_id) REFERENCES employee(emp_id) 
); 

CREATE TABLE vehicle
(
	vehicle_id VARCHAR(10),
    vehicle_type VARCHAR(20),
    vehicle_status VARCHAR(20),
    
    CONSTRAINT vehicle_pk PRIMARY KEY(vehicle_id)
);

CREATE TABLE delivery_expense
(
	expense_id VARCHAR(10),
    amount DOUBLE,
    expense_date date,
    delivery_id VARCHAR(10),
    
    CONSTRAINT delivery_expense_pk PRIMARY KEY(expense_id),
    CONSTRAINT delivery_expense_fk1 FOREIGN KEY(delivery_id) REFERENCES delivery(delivery_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE repair_expense
(
	expense_id VARCHAR(10),
    amount DOUBLE,
    expense_date date,
    repair_detail_id  VARCHAR(10),
    
    CONSTRAINT repair_expense_pk PRIMARY KEY(expense_id),
    CONSTRAINT repair_expense_fk1 FOREIGN KEY(repair_detail_id) REFERENCES repair_detail(repair_detail_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE showroom_expense
(
	expense_id VARCHAR(10),
    utility VARCHAR(10),
    amount DOUBLE,
    expense_date date,
    
    CONSTRAINT showroom_expense_pk PRIMARY KEY(expense_id)
);

SELECT * FROM supplier;
SELECT * FROM supplier_order;
SELECT * FROM supplier_order_return;
SELECT * FROM supplier_payment;
SELECT * FROM item;
SELECT * FROM customer_order;
SELECT * FROM customer_payment;
SELECT * FROM cart;
SELECT * FROM brand_new_item;
SELECT * FROM customer;
SELECT * FROM delivery;
SELECT * FROM delivery_expense;
SELECT * FROM vehicle;
SELECT * FROM employee;
SELECT * FROM delivery_employee;
SELECT * FROM system_user;
SELECT * FROM employee_attendance;
SELECT * FROM salary;
SELECT * FROM customer_complain;
SELECT * FROM repair_item;
SELECT * FROM repair_detail;
SELECT * FROM repair_expense;
SELECT * FROM showroom_expense

/*total 22 tables*/
/*use alter tables to change any attributes or constraints*/

CREATE TABLE cart
(
	cart_id VARCHAR(10),
    price DOUBLE,
    cart_date date,
    cust_id VARCHAR(10),
    item_code VARCHAR(20),
    
    CONSTRAINT cart_pk1 PRIMARY KEY(cart_id,item_code),
    CONSTRAINT cart_fk1 FOREIGN KEY(cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT cart_fk2 FOREIGN KEY(item_code) REFERENCES brand_new_item(item_code) ON DELETE CASCADE ON  UPDATE CASCADE 
);

CREATE TABLE brand_new_item
(
	item_code VARCHAR(20),
    
    CONSTRAINT brand_new_item_pk PRIMARY KEY( item_code),
    CONSTRAINT brand_new_item_fk1 FOREIGN KEY(item_code) REFERENCES item(item_code) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE customer
(
	cust_id VARCHAR(10),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    NIC varchar(10),
    emai varchar(30),
    contact_no VARCHAR(10),
    address VARCHAR(50),
    
    CONSTRAINT customer_pk PRIMARY KEY(cust_id)
);

SELECT * FROM item;
SELECT * FROM brand_new_item;
SELECT * FROM model
SELECT * FROM customer

INSERT INTO customer VALUES('C254', null, null, '999999999V', null, null,null);
