*** Settings ***
Resource  ../pageObjects/basePage.robot

Suite Setup  Open My Website
Suite Teardown  Close browser


*** Variables ***
${EMAIL_LOGIN_TXT}=       xpath://input[@id='SignInEmail']
${PASSWORD_LOGIN_TXT}=    xpath://input[@id='SignInPassword']
${LOGIN_BTN_TOP}=         xpath://button[@id='SignInButton']
${LOGIN_ERROR}=           class:woocommerce-error
${LOGIN_BTN}=             xpath://button[@id='SignInButtonComplete']
${HAMBURGER}=             class:css-1idhddb


${EMAIL_CREATE_TXT}=      id:reg_email
${EMAIL_CREATE_PASSW}=    id:reg_password
${CREATE_ACCOUNT_BTN}=    name:register
${CREATE_ACCOUNT_ERROR}=  class:woocommerce-error


*** Test Cases ***
Sign In With Wrong User Name
    Wait Until Element Is Visible  ${HAMBURGER}
    Sleep  5s
    Click Element  ${HAMBURGER}
    Click Element  ${LOGIN_BTN_TOP}
    Wait Until Element Is Visible  ${EMAIL_LOGIN_TXT}
    Input Text   ${EMAIL_LOGIN_TXT}  test2@test.bel
    Input Text  ${PASSWORD_LOGIN_TXT}  test123
    Click Element  ${LOGIN_BTN}
    Sleep  2s
    ${error}=  Get Text  css:div[class='css-1y9e552'] code
    Should Be Equal  ${error}  This email has not been registered.

Sign In With Wrong Password
    Input Text   ${EMAIL_LOGIN_TXT}  test2@test.be
    Input Text  ${PASSWORD_LOGIN_TXT}  test1234
    Click Element  ${LOGIN_BTN}
    Sleep  2s
    ${error}=  Get Text  css:div[class='css-1y9e552'] code
    Should Be Equal  ${error}  Email or password incorrect.

Sign In With Account
    Input Text   ${EMAIL_LOGIN_TXT}  test2@test.be
    Input Text  ${PASSWORD_LOGIN_TXT}  test123
    Click Element  ${LOGIN_BTN}
    Sleep  2s
    ${url}=  Get Location
    Should Be Equal  ${url}  https://brightshopapp.herokuapp.com/#/

Check Name
    Sleep  2s
    Wait Until Element Is Visible  ${HAMBURGER}
    Sleep  5s
    Click Element  ${HAMBURGER}
    Click Element  xpath://a[@href='#/profile']//button[@id='OrdersPageButton']
    Sleep  3s
    ${name}=  Get Text  css:body div[id='root'] div[class='App'] div div div[class='css-1jf7604'] div[id='SignIn'] div[class='css-kcntxh'] p:nth-child(2)
    Should Be Equal  ${name}  test

Check Surname
    ${surname}=  Get Text  css:body div[id='root'] div[class='App'] div div div[class='css-1jf7604'] div[id='SignIn'] div[class='css-kcntxh'] p:nth-child(4)
    Should Be Equal  ${surname}  test

Check Avatar
    Element Should Be Visible  xpath://img[@class='css-1wu7nrr']

Negative Credits Can't Be Bought
    ${credits}=  Get Text  css:body div[id='root'] div[class='App'] div div div[class='css-1jf7604'] div[id='SignIn'] div[class='css-kcntxh'] p:nth-child(8)
    Click Element  xpath://button[@class='css-1e9674f']
    Wait Until Element Is Visible  xpath://input[@placeholder='5']
    Input Text  xpath://input[@placeholder='5']  -5
    Sleep  2s
    Click Element  xpath://button[@type='submit']
    Sleep  2s
    ${newCredits}=  Get Text  css:body div[id='root'] div[class='App'] div div div[class='css-1jf7604'] div[id='SignIn'] div[class='css-kcntxh'] p:nth-child(8)
    Should Be Equal  ${credits}  ${newCredits}




