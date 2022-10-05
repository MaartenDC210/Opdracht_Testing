*** Settings ***
Resource  basePage.robot

*** Variables ***
${PAGE_SPECIFIC_TEXT}=  Your personal information

*** Keywords ***
Create Account Page Is Loaded
    Wait Until Page Contains  Your personal information
    [Return]  True
