*** Settings ***
Resource  ../pageObjects/basePage.robot

Suite Setup  Open My Website
Suite Teardown  Close browser

*** Variables ***
${SEARCH_FULL_TITLE}=  rogue city
${SEARCH_PART_OF_TITLE}=  rogue
${SEARCH_BAR}=  xpath://div[@class='MuiInputBase-root MuiOutlinedInput-root MuiAutocomplete-inputRoot jss1 MuiInputBase-fullWidth MuiInputBase-formControl MuiInputBase-adornedEnd MuiOutlinedInput-adornedEnd']
${SEARCH_BAR_TEXT_INPUT}=  css:header div[class='css-162x498'] div div div div input[id='mui-58023']
${ARROW_DOWN_KEY}=  \ue015
${ENTER_KEY}=  \ue007

*** Test Cases ***

Search A Movie With The Full Title
    Sleep  6s
    Click Element  ${SEARCH_BAR}
    Sleep  2s
    Input Text  ${SEARCH_BAR_TEXT_INPUT}  ${SEARCH_FULL_TITLE}
    Sleep  2s
    Press Keys  ${ARROW_DOWN_KEY}
    Sleep  5s
    Press Keys  ${ENTER_KEY}
    Sleep  5s
    ${movieName}=  Get Text  xpath://div[@class='css-rabwp9']
    Should Be Equal  ${movieName}  ${SEARCH_FULL_TITLE}


Search A Movie With A Part Of Title
    Sleep  5s
    Click Element  xpath://div[@class='css-ce9ngx']//button[@id='CloseModal']
    Sleep  6s
    Click Element  ${SEARCH_BAR}
    Sleep  2s
    Input Text  ${SEARCH_BAR_TEXT_INPUT}  ${SEARCH_PART_OF_TITLE}
    Sleep  2s
    Press Keys  ${ARROW_DOWN_KEY}
    Sleep  2s
    Press Keys  ${ARROW_DOWN_KEY}
    Sleep  5s
    Press Keys  ${ENTER_KEY}
    Sleep  5s
    ${movieName}=  Get Text  xpath://div[@class='css-rabwp9']
    Should Be Equal  ${movieName}  Rogue City
