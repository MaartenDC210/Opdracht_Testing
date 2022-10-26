*** Settings ***
Library    String
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
${MOVIE_NAME_UPPER}=      name:movieNameToUpper


*** Test Cases ***

After Hiring A Movie Credits Are Removed
    Wait Until Element Is Visible  ${HAMBURGER}
    Sleep  5s
    Click Element  ${HAMBURGER}
    Click Element  ${LOGIN_BTN_TOP}
    Wait Until Element Is Visible  ${EMAIL_LOGIN_TXT}
    Input Text   ${EMAIL_LOGIN_TXT}  test2@test.be
    Input Text  ${PASSWORD_LOGIN_TXT}  test123
    Click Element  ${LOGIN_BTN}
    Sleep  3s

    Comment  Get Current Credits
    Wait Until Element Is Visible  ${HAMBURGER}
    Sleep  5s
    Click Element  ${HAMBURGER}
    Click Element  xpath://a[@href='#/profile']//button[@id='OrdersPageButton']
    Sleep  3s
    ${credits}=  Get Text  css:body div[id='root'] div[class='App'] div div div[class='css-1jf7604'] div[id='SignIn'] div[class='css-kcntxh'] p:nth-child(8)
    ${creditsInt}=  Convert To Integer  ${credits}

    Comment  Hire Movie
    Click Element  xpath://img[@id='Logo']
    Sleep  2s
    Click Element  css:body > div:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div:nth-child(4) > div:nth-child(4) > div:nth-child(2) > img:nth-child(10)
    ${movieName}=  Get Text  xpath://div[@class='css-rabwp9']
    ${movieNameTemp}=  Convert To Uppercase  ${movieName}
    Set Global Variable  ${MOVIE_NAME_UPPER}  ${movieNameTemp}
    Sleep  3s

    Click Element  xpath://button[@id='RentMovieButton']

    Comment  Check New Credit Total
    Wait Until Element Is Visible  ${HAMBURGER}
    Click Element  ${HAMBURGER}
    Wait Until Element Is Visible  xpath://a[@href='#/profile']//button[@id='OrdersPageButton']
    Click Element  xpath://a[@href='#/profile']//button[@id='OrdersPageButton']
    Sleep  5s
    ${newCredits}=  Get Text  css:body div[id='root'] div[class='App'] div div div[class='css-1jf7604'] div[id='SignIn'] div[class='css-kcntxh'] p:nth-child(8)
    ${newCreditsInt}=  Convert To Integer  ${newCredits}
    Should Be True  ${newCreditsInt} < ${creditsInt}

After Hiring A Movie, The Movie Is In My List
    Sleep  2s
    Wait Until Element Is Visible  ${HAMBURGER}
    Click Element  ${HAMBURGER}
    Wait Until Element Is Visible  xpath://a[@href='#/orders']//button[@id='OrdersPageButton']
    Click Element  xpath://a[@href='#/orders']//button[@id='OrdersPageButton']
    Sleep  5s
    ${rentedMovieName}=  Get Text  xpath:/html[1]/body[1]/div[1]/div[1]/div[2]/div[3]/div[1]/div[1]/div[3]/p[1]
    Should Be Equal  ${MOVIE_NAME_UPPER}  ${rentedMovieName}
