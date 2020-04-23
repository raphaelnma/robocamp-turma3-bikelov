*** Settings ***
Resource        ../../../resources/services.robot

Test Setup      Create Session    bikelov       ${base_url}              

*** Test Cases ***
Create a new Bike Ad
    ${user_id}=     Get User Id         raphael_mantilha@yahoo.com.br
    ${payload}=     Convert To Json     {"name":"Bike Show","brand":"Marca Show","price":"15"}
    Remove Bike     ${payload['name']}

    ${resp}=        Post Bike Ad        ${user_id}      ${payload}      elleven.jpg       
    
    Should Be Equal As Strings       ${resp.status_code}     200

Empty Brand
    [Template]      Required Fields
    {"name":"Bike Show","brand":"","price":"15"}       1002        Brand is required

Empty Name
    [Template]      Required Fields
    {"name":"","brand":"Marca Show","price":"15"}       1001        Bike name is required

*** Keywords ***
Required Fields
    [Arguments]     ${json}     ${expected_bode}    ${expected_message}

    ${user_id}=     Get User Id         raphael_mantilha@yahoo.com.br
    ${payload}=     Convert To Json     ${json}
    Remove Bike     ${payload['name']}

    ${resp}=        Post Bike Ad        ${user_id}      ${payload}      elleven.jpg      
    Log             ${resp.text} 
    
    ${business_code}=   Convert To Integer  ${resp.json()['code']}

    Should Be Equal As Strings       ${resp.status_code}     412
    Should Be Equal                  ${resp.json()['code']}  ${business_code}    
    Dictionary Should Contain Value  ${resp.json()}         ${expected_message}        
