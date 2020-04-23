*** Settings ***
Resource        ../../../resources/services.robot

Test Setup      Create Session    bikelov       ${base_url}       

*** Test Cases ***
Delete Unique Bike Ad
     ${user_id}=     Get User Id         raphael_mantilha@yahoo.com.br
     ${bike_ad}=     Convert To Json     {"name":"Vulcano","brand":"Monark","price":"10","thumbnail":"vulcan.jpg"}
     
     ${bike_ad_id}=      Create Bike Ad      ${bike_ad}      ${user_id}
     
     ${resp}=            Delete Bike Ad By Id   ${bike_ad_id}  ${user_id}
     Log                 ${resp.text}

     Should Be Equal As Strings         ${resp.status_code}      204

Delete Ad Not Found
     ${user_id}=     Get User Id         raphael_mantilha@yahoo.com.br
     ${bike_ad_id}=      Get Mongo Id

     ${resp}=            Delete Bike Ad By Id   ${bike_ad_id}  ${user_id}
      Log                 ${resp.text}

       Should Be Equal As Strings         ${resp.status_code}      204

User Unauthorized
     ${bike_ad_id}=      Get Mongo Id

     ${resp}=            Delete Bike Ad By Id   ${bike_ad_id}  ${EMPTY}
      Log                 ${resp.text}

       Should Be Equal As Strings         ${resp.status_code}      401

     