*** Settings ***
Resource  basePage.robot

*** Variables ***
${EMAIL_LOGIN_TXT}=       id:username
${PASSWORD_LOGIN_TXT}=    id:password
${LOGIN_BTN}=             xpath://input[@name='login']
${LOGIN_ERROR}=           class:woocommerce-error

${EMAIL_CREATE_TXT}=      id:reg_email
${EMAIL_CREATE_PASSW}=    id:reg_password
${CREATE_ACCOUNT_BTN}=    name:register
${CREATE_ACCOUNT_ERROR}=  class:woocommerce-error

*** Keywords ***
Log In With Account
    [Arguments]  ${emailaddress}=${EMPTY}  ${password}=${EMPTY}
    Wait Until Element Is Visible  ${EMAIL_LOGIN_TXT}
    Input Text  ${EMAIL_LOGIN_TXT}  ${emailaddress}
    Input Text  ${PASSWORD_LOGIN_TXT}  ${password}
    Click Element  ${LOGIN_BTN}

Get Login Error Message
    Wait Until Element Is Visible  ${LOGIN_ERROR}
    ${text}=  Get Text  ${LOGIN_ERROR}
    [Return]  ${text}

Create Account
    [Arguments]  ${emailaddress}=${EMPTY}  ${password}=${EMPTY}
    Wait Until Element Is Visible  ${EMAIL_CREATE_TXT}
    Input Text  ${EMAIL_CREATE_TXT}  ${emailaddress}
    Input Text  ${EMAIL_CREATE_PASSW}  ${password}
    Sleep  2s
    Click Element  ${EMAIL_CREATE_TXT}
    Click Element  ${CREATE_ACCOUNT_BTN}

Get Create Account Error Message
    Wait Until Element Is Visible  ${CREATE_ACCOUNT_ERROR}
    ${text}=  Get Text  ${CREATE_ACCOUNT_ERROR}
    [Return]  ${text}