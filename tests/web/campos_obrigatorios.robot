*** Settings ***
Documentation   Criar Anúncio
...             Para que eu possa disponibilizar bikes para locação 
...             Sendo um anunciante
...             Quero poder cadastrar um novo anúncio

Resource    ../../resources/steps_kw.robot

Suite Setup     Run Keywords    Logged with "eu@papito.io"
...             AND             E eu acesso o formulário de cadastro de anúncio
Suite Teardown  End Session

Test Teardown   End Test

Test Template   Anúncio não cadastrado

*** Variables ***
${no_thumb}=    {"thumb": "", "name": "Elleven Rocker 26 marchas", "brand": "Shimano", "price": "15"}
${no_name}=     {"thumb": "elleven.jpg", "name": "", "brand": "Shimano", "price": "15"}
${no_brand}=    {"thumb": "elleven.jpg", "name": "Elleven Rocker 26 marchas", "brand": "", "price": "15"}

*** Test Cases ***      bike                alert
Sem foto no anúncio     ${no_thumb}      Precisamos de uma foto para o seu anúncio!
Não informa o nome      ${no_name}          Informe a descrição do anúncio!
Não informa a marca     ${no_brand}         Informe a marca da sua Bike :)

*** Keywords ***
Anúncio não cadastrado
    [Arguments]     ${bike}     ${text}

    Dado que eu tenho uma "${bike}" muito bonita
    Quando eu faço o anúncio desta bike
    Então devo ver uma mensagem de erro "${text}"

