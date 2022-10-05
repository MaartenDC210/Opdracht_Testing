*** Settings ***
Resource  basePage.robot

*** Variables ***
${SIGNIN_LNK}=       xpath://a[normalize-space()='My Account']

*** Keywords ***
Go To Signin Page
    Click Element  ${SIGNIN_LNK}

