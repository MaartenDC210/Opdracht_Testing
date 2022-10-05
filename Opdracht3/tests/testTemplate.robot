*** Settings ***
Resource  ../pageObjects/homePage.robot
Resource  ../pageObjects/signInPage.robot

Suite Setup  Open My Website
Suite Teardown  Close browser
Test Setup  Go To Signin Page

*** Test Cases ***
Login Without Email Address
    Log In With Account
    ${errorMessage}=  Get Login Error Message
    Should Contain  ${errorMessage}  Username is required

Login With Unexisting Account
    Log In With Account  notanaccount@gmail.com  password
    ${errorMessage}=  Get Login Error Message
    Should Contain  ${errorMessage}  A user could not be found with this email address

Login Without Password
    Log In With Account  notanaccount@gmail.com
    ${errorMessage}=  Get Login Error Message
    Should Contain  ${errorMessage}  Password is required.

