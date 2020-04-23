*** Settings ***
Resource        ../../../resources/services.robot

Test Setup      Create Session    bikelov       ${base_url}       

*** Test Cases ***
Get Unique Bike Ad
     ${user_id}=     Get User Id         raphael_mantilha@yahoo.com.br
     ${bike_ad}=     Convert To Json     {"name":"Bike Show","brand":"Marca Show","price":"15","thumbnail":"elleven.jpg"}
     
     ${bike_ad_id}=      Create Bike Ad      ${bike_ad}      ${user_id}
     
     ${resp}=            Get Bike Ad By Id   ${bike_ad_id}  ${user_id}
     Log                 ${resp.text}

     Should Be Equal As Strings         ${resp.status_code}      200
     Dictionary Should Contain Value    ${resp.json()}           ${bike_ad['name']}  
     Dictionary Should Contain Value    ${resp.json()}           ${bike_ad['brand']}  

Bike Ad Not Found
     ${user_id}=     Get User Id         raphael_mantilha@yahoo.com.br
     ${bike_ad_id}=      Get Mongo Id

     ${resp}=            Get Bike Ad By Id   ${bike_ad_id}  ${user_id}
      Log                 ${resp.text}

       Should Be Equal As Strings         ${resp.status_code}      404

User Unauthorized
     ${bike_ad_id}=      Get Mongo Id

     ${resp}=            Get Bike Ad By Id   ${bike_ad_id}  ${EMPTY}
      Log                 ${resp.text}

       Should Be Equal As Strings         ${resp.status_code}      401

     