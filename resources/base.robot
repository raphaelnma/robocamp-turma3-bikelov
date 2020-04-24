*** Settings ***
Library     SeleniumLibrary

Resource    elements.robot

*** Variables ***
${BASE_URL}     https://bikelov-anunciante.herokuapp.com

*** Keywords ***
Start Session
    Open Browser                    about:blank   headlesschrome
    Set Selenium Implicit Wait      5
    Set Window Size                 1440    900

End Session
    Close Browser

Logged with "${email}"
    Start Session
    Go To       ${BASE_URL}

    Input Text                      ${INPUT_EMAIL}                        ${email}
    Click Element                   ${BUTTON_LOGIN}

     Page Should Contain Element     ${DIV_DASH}  

End Test
    Capture Page Screenshot