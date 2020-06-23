# Payment-Management-System

[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)   
[![forthebadge](https://forthebadge.com/images/badges/made-with-java.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

---

The goal of the project is to create a complete payment system with all the basic functionality.  
I deployed the application on the hosting. `Go to this address:` https://payment-management-system.herokuapp.com/  

## Used tools for project implementation

`Primary:` MySQL 5.7, Java 8 (Core + Servlets + JDBC + JSP), JSTL, Maven 3, HTML CSS, JavaScript, jQuery v3.4, Bootstrap v4.4.
`Secondary:` Apache Tomcat v9.0, Apache Commons Lang v2.6, Apache Log4j v1.2, JUnit v4.13, Mockito v1.10.  
<i>*For more information on dependencies and plugins, see the pom.xml file.</i>

## Initialization and launch of the project

For the correct launch and stable operation of the site (locally) you need to:
- Download and uncompress the .zip archive of this repository. I recommend cloning a project (if you know Git):  
    `git clone https://github.com/SValentyn/Payment-Management-System.git`
- Specify the correct path to the JDK home folder in the IDE.
- Connect, configure and start your database server.
- Import the database dump from the /resources/sql/dump.sql file (substituting your DB name). Optionally, execute trigger scripts.
- Specify the correct database connection parameters in the /webapp/META-INF/context.xml file
- Uncomment the block of code needed for your purposes in the /persistence/dao/impl/QueryExecutor.java file (contains the basic methods for working with the DB).
- Run the project build command: `mvn clean package`
- Connect and configure your web server to deploy the project locally.
- Verify that all components are configured correctly and that all services are running.
- In the browser, go to this address: `http://localhost:8080/`

## Use Case diagrams

All options for using the system can be found in Use Case diagrams. Since there are two types of users in the system: Regular User (Client) and Administrator, the corresponding two Use Case diagrams were created. Their main difference from each other is that they have different privileges and specific capabilities.

`Use Case diagram for Regular User (Client):`  

`Use Case diagram for Administrator:`  

## Support

Patches are encouraged, and may be submitted by forking this project and submitting a pull request through GitHub. Please see CONTRIBUTING.md for more details.

---  

I hope my project will help you! Communication with me: https://t.me/vlnt_snk
