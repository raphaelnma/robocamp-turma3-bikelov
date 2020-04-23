*** Settings ***
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem  

Library     lib/mongo.py

*** Variables ***
${base_url}     http://bikelov-api.herokuapp.com

*** Keywords ***
### /sessions
Post Session
    [Arguments]     ${payload}  

    &{headers}=     Create Dictionary       Content-Type=application/json   
    
    ${resp}=        Post Request    bikelov   /sessions       data=${payload}     headers=${headers}       
    [return]        ${resp}    

Get User Id
    [Arguments]     ${email}

    ${payload}=     Convert To Json  {"email":"${email}"}
    ${resp}=        Post Session  ${payload}
    ${user_id}=     Convert To String   ${resp.json()['_id']}
    [return]        ${user_id}

### /bikes
Post Bike Ad
    [Arguments]     ${user_id}      ${payload}      ${thumb}

    &{headers}=     Create Dictionary       user_id=${user_id}

    ${file_bin}=    Get Binary file     ${CURDIR}/../resources/images/${thumb}

    &{files}=       Create Dictionary       thumbnail=${file_bin}
    
    ${resp}=        Post Request    bikelov   /bikes       data=${payload}     headers=${headers}   files=${files}     
    [return]        ${resp}   

Get Bike Ad By Id
    [Arguments]     ${bike_id}      ${user_id}

    &{headers}      Create Dictionary        Content-Type=application/json   user_id=${user_id}

    ${resp}=        Get Request             bikelov     /bikes/${bike_id}       headers=${headers}

    [return]        ${resp}

Delete Bike Ad By Id
    [Arguments]     ${bike_id}      ${user_id}

    &{headers}      Create Dictionary        Content-Type=application/json   user_id=${user_id}

    ${resp}=        Delete Request             bikelov     /bikes/${bike_id}       headers=${headers}

    [return]        ${resp}

### Helpers
Convert To Json
    [Arguments]      ${target}   

    ${result}=      evaluate    json.loads($target)     json
    [return]        ${result}