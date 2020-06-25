# Payment-Management-System

[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)   
[![forthebadge](https://forthebadge.com/images/badges/made-with-java.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

---

The goal of the project is to create a complete payment system with all the basic functionality.  
I deployed the application on the hosting.     
`Go to this address:` https://payment-management-system.herokuapp.com/  

## Used tools and patterns for project implementation

`Primary:` MySQL 5.7, Java 8 (Core + Servlets + JDBC + JSP), JSTL, Maven 3, HTML CSS, JS, jQuery v3.4, Bootstrap v4.4.    
`Secondary:` Apache Tomcat v9.0, Apache Commons Lang v2.6, Apache Log4j v1.2, JUnit v4.13, Mockito v1.10.    
<i>*For more information on dependencies and plugins, see the pom.xml file.</i>  

When implementing business logic algorithms, I used GoF patterns (Singleton, Builder, Factory Method, Command, Strategy), as well as MVC and DAO patterns.

## Initialization and launch of the project

For the correct launch and stable operation of the site (locally) you need to:
- Download and uncompress the .zip archive of this repository. I recommend cloning a project (if you know Git):  
    `$ git clone https://github.com/SValentyn/Payment-Management-System.git`
- Specify the correct path to the JDK home folder in the IDE.
- Connect, configure and start your database server.
- Import the database dump from the /resources/sql/dump.sql file (substituting your DB name).
- Specify the correct database connection parameters in the /webapp/META-INF/context.xml file
- Uncomment the block of code needed for your purposes in the /persistence/dao/impl/QueryExecutor.java file (contains the basic methods for working with the DB).
- Run the project build command from the root folder: `$ mvn clean package`
- Connect and configure your web server to deploy the project locally.
- Verify that all components are configured correctly and that all services are running.
- In the browser, go to this address: `http://localhost:8080/`  

If you know Docker, use these commands by running them from the root folder:  
&nbsp;&nbsp;&nbsp;&nbsp;`$ docker build -f Dockerfile -t pms-assembly .`  
&nbsp;&nbsp;&nbsp;&nbsp;`$ docker run --name mysql57 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pppp -d mysql/mysql-server:5.7`  
&nbsp;&nbsp;&nbsp;&nbsp;`$ docker run -d -p 8080:8080 pms-assembly`  
Or use this command by running it from the root folder:  
&nbsp;&nbsp;&nbsp;&nbsp;`$ docker-compose up --build -V`  

I advise you to use the first option with manual installation and configuration.  

## Use Case diagrams

All options for using the system can be found in Use Case diagrams. Since there are two types of users in the system: Regular User (Client) and Administrator, the corresponding two Use Case diagrams were created. Their main difference from each other is that they have different privileges and specific capabilities.

`Use Case diagram for Regular User (Client):`  
<p align="center">
  <img src="https://github.com/SValentyn/Payment-Management-System/blob/master/diagrams/UseCase_for_Client.png" alt="UseCase for Regular User">
</p>

`Use Case diagram for Administrator:`  
<p align="center">
  <img src="https://github.com/SValentyn/Payment-Management-System/blob/master/diagrams/UseCase_for_Admin.png" alt="UseCase for Admin">
</p>

## Support

Patches are encouraged, and may be submitted by forking this project and submitting a pull request through GitHub. Please see CONTRIBUTING.md for more details.

---  

I hope my project will help you! Communication with me: https://t.me/vlnt_snk
