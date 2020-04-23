*** Settings ***
Resource    base.robot
Library     ./lib/mongo.py

*** Keywords ***
Dado que acesso a página login
    Go To   ${BASE_URL}

Quando eu submeto minha credencial de login "${email}"
    Input Text                      ${INPUT_EMAIL}                        ${email}
    Click Element                   ${BUTTON_LOGIN}

Então a área logada deve ser exibida
    Page Should Contain Element     ${DIV_DASH} 

Então devo ver a mensagem de alerta "${expected_message}"
    Element Text Should Be  ${ALERT_DARK}   ${expected_message}   

## Anúncios
Dado que eu tenho uma "${bike_string}" muito bonita
    ${bike_json}=   evaluate    json.loads($bike_string)    json
    Log           ${bike_json['name']}
    Set Test Variable   ${bike_json}
    Remove Bike         ${bike_json['name']}

E eu acesso o formulário de cadastro de anúncio
    Click Link      /new

Quando eu faço o anúncio desta bike
    Run Keyword If  '${bike_json['thumb']}'
    ...     Choose File     ${INPUT_THUMB}            ${CURDIR}/images/${bike_json['thumb']}    

    Clear Element Text  ${INPUT_NAME}
    Input Text          ${INPUT_NAME}               ${bike_json['name']}
    Clear Element Text  ${INPUT_BRAND}
    Input Text      ${INPUT_BRAND}                   ${bike_json['brand']}
    Input Text      ${INPUT_PRICE}     ${bike_json['price']}
    Click Element   ${BUTTON_SUBMIT}               
    Sleep           5

Então devo ver minha bike na lista de anúncios
    Wait Until Element Is Visible   ${BIKE_ITEM}   
    Element Should Contain          ${BIKE_LIST}     ${bike_json['name']}

E o valor para locação deve ser igual a "${expected_price}/dia"
    Element Should Contain      ${BIKE_LIST}     ${expected_price}

Então devo ver uma mensagem de erro "${expected_message}"
    Element Text Should Be  ${ALERT_ERROR}    ${expected_message}   