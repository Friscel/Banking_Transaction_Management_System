**Banking Transaction Management System**

- A secure and automated database system for managing banking operations, transactions, and audit trails.

---------------------------------------------------------------------------------------------------------

**Developed by Group 7**

- Bayran, Ceejay

- Casubuan, Jayboy

- Mance, Arian

- Rivera, Friscel

- Salazar, Wendelyn

- Versoza, Taniah Jane

----------------------------------------------------------------------------------------------------------

**Project Overview**

- The Banking Transaction Management System is a comprehensive database project designed to simulate real-world banking operations such as account management, client registration, fund transfers, and transaction logging.

- This system demonstrates advanced database concepts including transaction control, triggers, stored procedures, views, role-based access, and backup and recovery mechanisms, ensuring data consistency, security, and reliability in financial operations.

----------------------------------------------------------------------------------------------------------

**Project Objectives**

This project aims to:

- Implement a structured banking database using normalized design

- Ensure data integrity during financial transactions

- Automate balance updates and audit logging

- Simulate real banking fund transfers with rollback protection

- Apply role-based user access control

- Demonstrate backup and restore processes

----------------------------------------------------------------------------------------------------------

**System Features**

**Branch Management**

- Stores branch information including branch name and location

- Links clients to their respective branches

**Client Management**

- Registers bank clients with personal and contact details

- Supports full CRUD operations (Create, Read, Update, Delete)

**Account Management**

- Maintains different account types (Savings, Checking)

- Tracks real-time account balance and status

- Ensures account-client relationship integrity

**Transaction Processing**

- Supports Deposit and Withdraw operations

- Automatically updates account balances using triggers

- Records all transaction history with timestamps

**Fund Transfer System**

- Stored procedure for transferring funds between accounts

- Validates sufficient balance before transfer

- Uses START TRANSACTION, COMMIT, and ROLLBACK to ensure consistency

**Audit Trail Logging**

- Trigger-generated audit logs for every transaction

- Records action type and timestamp for accountability

**Account Summary View**

- Predefined SQL View for quick account reporting

- Displays client name, account type, and balance

**User Access Control**

- Role-based users (ADMIN and TELLER)

- Simulates real banking authorization levels

**Backup and Restore**

- SQL dump-based backup and restore simulation

- Ensures data recovery capability

----------------------------------------------------------------------------------------------------------

**Database Schema**

Tables

- Branches – Bank branch details

- Clients – Client personal information

- Accounts – Account details and balances

- Transactions – Deposit and withdrawal records

- Audit_Logs – Transaction activity logs

- Users – System users with role assignments

----------------------------------------------------------------------------------------------------------

**Database Components**

**Triggers**

- Automatically update account balance after transactions

- Generate audit logs for every transaction event

**Stored Procedures**

- Fund transfer procedure with balance validation

- Ensures atomicity using transaction control

**Views**

- Account summary view for reporting and monitoring

**SQL Concepts Demonstrated**

- Database normalization and ERD relationships

- Primary and foreign key constraints

- SQL joins and subqueries

- Stored procedures and triggers

- Transaction management (COMMIT / ROLLBACK)

- Role-based security

- Backup and restore using SQL dump

----------------------------------------------------------------------------------------------------------

**Project Deliverables**

✔ Normalized ERD with relationship rules

✔ Complete DDL and sample data scripts

✔ CRUD operations for client registration

✔ SQL joins and subqueries for transaction history

✔ Stored procedure for fund transfer with balance checking

✔ Trigger for automated audit log generation

✔ View for account summary reporting

✔ Backup and restore SQL dump

✔ User access control (Admin / Teller)

✔ Test report and project presentation
